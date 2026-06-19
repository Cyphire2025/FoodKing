<?php

namespace App\Services;

use App\Libraries\QueryExceptionLibrary;
use App\Models\AppDesignSetting;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AppDesignService
{
    private function setting(): AppDesignSetting
    {
        return AppDesignSetting::firstOrCreate(
            ['group' => 'app_design', 'key' => 'customer_app'],
            ['payload' => ['primary_color' => '#9FD789']]
        );
    }

    public function list(): array
    {
        try {
            $setting = $this->setting();
            $payload = array_merge(['primary_color' => '#9FD789'], $setting->payload ?? []);

            return [
                'primary_color' => $payload['primary_color'] ?: '#9FD789',
                'banner_1_url'  => $setting->banner_one_url,
                'banner_2_url'  => $setting->banner_two_url,
            ];
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    public function updateColor(Request $request): array
    {
        try {
            $setting = $this->setting();
            $payload = array_merge(['primary_color' => '#9FD789'], $setting->payload ?? []);
            $payload['primary_color'] = $request->input('primary_color', '#9FD789');
            $setting->payload = $payload;
            $setting->save();

            return $this->list();
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    public function updateBanners(Request $request): array
    {
        try {
            $setting = $this->setting();

            if ($request->hasFile('banner_1')) {
                $setting->clearMediaCollection('app-banner-1');
                $setting->addMediaFromRequest('banner_1')->toMediaCollection('app-banner-1');
            }

            if ($request->hasFile('banner_2')) {
                $setting->clearMediaCollection('app-banner-2');
                $setting->addMediaFromRequest('banner_2')->toMediaCollection('app-banner-2');
            }

            return $this->list();
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }
}
