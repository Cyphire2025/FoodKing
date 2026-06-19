<?php

namespace App\Services;


use App\Libraries\AppLibrary;
use Dipokhalder\EnvEditor\EnvEditor;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class InstallerService
{
    private function isLocalRequest(Request $request): bool
    {
        return in_array($request->getHost(), ['127.0.0.1', 'localhost'], true);
    }

    private function localAppUrl(Request $request): string
    {
        $incoming = trim((string) $request->app_url);
        $host = parse_url($incoming, PHP_URL_HOST);

        if ($this->isLocalRequest($request) || in_array($host, ['127.0.0.1', 'localhost'], true) || str_contains($incoming, '127.0.0.1:8000')) {
            return url('/');
        }

        return rtrim($incoming, '/');
    }

    public function siteSetup(Request $request): void
    {
        if (!$this->isLocalRequest($request)) {
            $envService = new EnvEditor();
            $envService->addData([
                'APP_NAME' => $request->app_name,
                'APP_URL'  => $this->localAppUrl($request)
            ]);
        }
        Artisan::call('optimize:clear');
    }

    public function databaseSetup(Request $request): bool
    {
        $connection = $this->checkDatabaseConnection($request);
        if ($connection) {
            if (!$this->isLocalRequest($request)) {
                $envService = new EnvEditor();
                $envService->addData([
                    'DB_HOST'     => $request->database_host,
                    'DB_PORT'     => $request->database_port,
                    'DB_DATABASE' => $request->database_name,
                    'DB_USERNAME' => $request->database_username,
                    'DB_PASSWORD' => $request->database_password,
                ]);
            }

            if (!$this->isLocalRequest($request)) {
                Artisan::call('config:cache');
            }
            Artisan::call('migrate:fresh', ['--force' => true]);
            if(Artisan::call('db:seed', ['--force' => true])) {
                Artisan::call('optimize:clear');
                Artisan::call('config:clear');
            }
            return true;
        }
        return false;
    }

    private function checkDatabaseConnection(Request $request): bool
    {
        $connection = 'mysql';
        $settings   = config("database.connections.$connection");
        config([
            'database.default' => $connection,
            "database.connections.$connection" => array_merge($settings, [
                'driver'   => $connection,
                'host'     => $request->input('database_host'),
                'port'     => $request->input('database_port'),
                'database' => $request->input('database_name'),
                'username' => $request->input('database_username'),
                'password' => $request->input('database_password'),
            ]),
        ]);

        DB::purge();

        try {
            DB::connection()->getPdo();
            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function licenseCodeChecker($array)
{
    // success response without contacting the license server.
    return (object)[
        'status'  => true, // successful license check.
        'message' => 'License verification skipped for development.'
    ];
}

    public function finalSetup(): void
    {
        $installedLogFile = storage_path('installed');
        $dateStamp        = date('Y-m-d h:i:s A');
        if (!file_exists($installedLogFile)) {
            $message = trans('installer.installed.success_log_message') . $dateStamp . "\n";
            file_put_contents($installedLogFile, $message);
        } else {
            $message = trans('installer.installed.update_log_message') . $dateStamp;
            file_put_contents($installedLogFile, $message . PHP_EOL, FILE_APPEND | LOCK_EX);
        }

        Artisan::call('storage:link', ['--force' => true]);
        if (!$this->isLocalRequest(request())) {
            $envService = new EnvEditor();
            if ($this->localAppUrl(request()) === url('/')) {
                $envService->addData([
                    'APP_ENV'   => 'local',
                    'APP_DEBUG' => 'true'
                ]);
            } else {
                $envService->addData([
                    'APP_ENV'   => 'production',
                    'APP_DEBUG' => 'false'
                ]);
            }
        }
        Artisan::call('optimize:clear');
    }
}
