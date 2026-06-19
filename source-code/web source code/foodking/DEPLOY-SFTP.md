# SFTP live deploy

This project can upload local file changes to the live `order.kahumbo.co.uk` hosting account through SFTP.

## Files

- `.deploy/sftp.credentials.json` stores the server credentials and remote path. This folder is ignored by Git.
- `scripts/deploy-sftp.mjs` handles test, file upload, directory upload, and watch mode.
- `start-sftp-watch.bat` starts watch mode on Windows.

## Commands

```powershell
npm run deploy:test
```

Checks the SFTP login and remote folder without uploading anything.

```powershell
npm run deploy:file -- app/Http/Controllers/ExampleController.php
```

Uploads one changed file.

```powershell
npm run deploy:dir -- public/build
```

Uploads a folder.

```powershell
npm run deploy:watch
```

Keeps running and uploads local file additions/changes automatically.

## Notes

- The cPanel URL uses port `2083`, but SFTP normally uses port `22`. The current credentials file uses `kahumbo.co.uk:22`, which has been tested successfully.
- The remote target is currently `/home/kahumboco/order.kahumbo.co.uk`.
- Local deletes do not delete remote files unless `deleteRemoteOnLocalDelete` is changed to `true` in `.deploy/sftp.credentials.json`.
- Ignored folders include `.deploy`, `node_modules`, `vendor`, Laravel cache/session/view files, logs, and local `.env` files.
- For frontend asset changes, run `npm run build`, then upload `public/build` or keep watch mode running while the build output changes.
