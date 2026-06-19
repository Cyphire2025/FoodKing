import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import SftpClient from 'ssh2-sftp-client';
import chokidar from 'chokidar';
import ignore from 'ignore';

const root = process.cwd();
const credentialPath = path.join(root, '.deploy', 'sftp.credentials.json');

const baseIgnoreRules = [
    '.git/',
    '.deploy/',
    'node_modules/',
    'vendor/',
    'storage/framework/cache/',
    'storage/framework/sessions/',
    'storage/framework/testing/',
    'storage/framework/views/',
    'storage/logs/',
    'bootstrap/cache/*.php',
    'public/hot',
    'public/storage/',
    '.env',
    '.env.*',
    '*.log',
    'npm-debug.log',
    'yarn-error.log'
];

function loadCredentials() {
    if (!fs.existsSync(credentialPath)) {
        throw new Error(`Missing SFTP credentials file: ${credentialPath}`);
    }

    const credentials = JSON.parse(fs.readFileSync(credentialPath, 'utf8'));
    for (const key of ['host', 'port', 'username', 'password', 'remotePath']) {
        if (!credentials[key]) {
            throw new Error(`Missing "${key}" in ${credentialPath}`);
        }
    }
    return credentials;
}

function createIgnoreMatcher() {
    const matcher = ignore().add(baseIgnoreRules);
    const gitignorePath = path.join(root, '.gitignore');
    if (fs.existsSync(gitignorePath)) {
        matcher.add(fs.readFileSync(gitignorePath, 'utf8'));
    }
    return matcher;
}

const matcher = createIgnoreMatcher();

function toRelative(localPath) {
    return path.relative(root, path.resolve(root, localPath)).replace(/\\/g, '/');
}

function shouldSkip(localPath) {
    const relativePath = toRelative(localPath);
    return !relativePath || relativePath.startsWith('..') || matcher.ignores(relativePath);
}

function remoteFor(credentials, localPath) {
    const relativePath = toRelative(localPath);
    return `${credentials.remotePath.replace(/\/+$/, '')}/${relativePath}`;
}

async function withSftp(task) {
    const credentials = loadCredentials();
    const sftp = new SftpClient();
    try {
        await sftp.connect({
            host: credentials.host,
            port: Number(credentials.port),
            username: credentials.username,
            password: credentials.password,
            readyTimeout: 30000
        });
        await task(sftp, credentials);
    } finally {
        await sftp.end().catch(() => {});
    }
}

async function ensureRemoteDirectory(sftp, remoteFilePath) {
    const directory = path.posix.dirname(remoteFilePath);
    await sftp.mkdir(directory, true);
}

async function uploadFile(sftp, credentials, localPath) {
    if (shouldSkip(localPath)) {
        return;
    }

    const stats = fs.statSync(localPath);
    if (!stats.isFile()) {
        return;
    }

    const remotePath = remoteFor(credentials, localPath);
    await ensureRemoteDirectory(sftp, remotePath);
    await sftp.fastPut(localPath, remotePath);
    console.log(`uploaded ${toRelative(localPath)} -> ${remotePath}`);
}

async function removeRemoteFile(sftp, credentials, localPath) {
    if (!credentials.deleteRemoteOnLocalDelete || shouldSkip(localPath)) {
        return;
    }

    const remotePath = remoteFor(credentials, localPath);
    await sftp.delete(remotePath).catch((error) => {
        if (!String(error.message || '').includes('No such file')) {
            throw error;
        }
    });
    console.log(`deleted ${remotePath}`);
}

async function uploadDirectory(sftp, credentials, localDirectory) {
    const absoluteDirectory = path.resolve(root, localDirectory);
    const entries = fs.readdirSync(absoluteDirectory, { withFileTypes: true });

    for (const entry of entries) {
        const localPath = path.join(absoluteDirectory, entry.name);
        if (shouldSkip(localPath)) {
            continue;
        }

        if (entry.isDirectory()) {
            await uploadDirectory(sftp, credentials, localPath);
        } else if (entry.isFile()) {
            await uploadFile(sftp, credentials, localPath);
        }
    }
}

async function watchChanges() {
    const credentials = loadCredentials();
    console.log(`watching ${root}`);
    console.log(`remote target: ${credentials.username}@${credentials.host}:${credentials.remotePath}`);

    const queue = [];
    let working = false;

    async function enqueue(type, localPath) {
        queue.push({ type, localPath });
        if (working) {
            return;
        }

        working = true;
        while (queue.length) {
            const next = queue.shift();
            try {
                await withSftp(async (sftp, freshCredentials) => {
                    if (next.type === 'unlink') {
                        await removeRemoteFile(sftp, freshCredentials, next.localPath);
                    } else {
                        await uploadFile(sftp, freshCredentials, next.localPath);
                    }
                });
            } catch (error) {
                console.error(`deploy failed for ${toRelative(next.localPath)}: ${error.message}`);
            }
        }
        working = false;
    }

    chokidar.watch('.', {
        cwd: root,
        ignoreInitial: true,
        ignored: (watchedPath) => watchedPath !== '.' && shouldSkip(watchedPath),
        persistent: true,
        awaitWriteFinish: {
            stabilityThreshold: 750,
            pollInterval: 100
        }
    })
        .on('add', (localPath) => enqueue('add', localPath))
        .on('change', (localPath) => enqueue('change', localPath))
        .on('unlink', (localPath) => enqueue('unlink', localPath));
}

const [command, target = '.'] = process.argv.slice(2);

if (command === 'watch') {
    await watchChanges();
} else if (command === 'test') {
    await withSftp(async (sftp, credentials) => {
        const listing = await sftp.list(credentials.remotePath);
        console.log(`connected to ${credentials.username}@${credentials.host}:${credentials.remotePath}`);
        console.log(`remote entries: ${listing.length}`);
    });
} else if (command === 'file') {
    await withSftp((sftp, credentials) => uploadFile(sftp, credentials, target));
} else if (command === 'dir') {
    await withSftp((sftp, credentials) => uploadDirectory(sftp, credentials, target));
} else {
    console.log('Usage:');
    console.log('  npm run deploy:watch');
    console.log('  npm run deploy:file -- relative/path/to/file.php');
    console.log('  npm run deploy:dir -- app');
}
