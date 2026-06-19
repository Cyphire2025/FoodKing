<?php

namespace App\Services;

use App\Libraries\QueryExceptionLibrary;
use App\Models\AppIntroSetting;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AppIntroVideoService
{
    private function setting(): AppIntroSetting
    {
        return AppIntroSetting::firstOrCreate(
            ['group' => 'app_intro', 'key' => 'app_intro_media'],
            ['payload' => json_encode('')]
        );
    }

    /**
     * @throws Exception
     */
    public function list(): array
    {
        try {
            $setting = $this->setting();

            return [
                'media_url'  => $setting->media_url,
                'media_type' => $setting->media_type,
            ];
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    /**
     * @throws Exception
     */
    public function update(Request $request): array
    {
        try {
            $setting = $this->setting();

            if ($request->hasFile('app_intro_media')) {
                $setting->clearMediaCollection('app-intro-media');
                $setting->addMediaFromRequest('app_intro_media')->toMediaCollection('app-intro-media');
            }

            return $this->list();
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }
}
