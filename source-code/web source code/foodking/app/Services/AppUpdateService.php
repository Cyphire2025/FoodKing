<?php

namespace App\Services;

use App\Libraries\QueryExceptionLibrary;
use App\Models\AppUpdateSetting;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AppUpdateService
{
    private function defaultPayload(): array
    {
        return [
            'heading'          => '',
            'description'      => '',
            'button_one_enabled' => false,
            'button_one_text'    => '',
            'button_one_link'    => '',
            'button_two_enabled' => false,
            'button_two_text'    => '',
            'button_two_link'    => '',
        ];
    }

    /**
     * @throws Exception
     */
    public function list(): array
    {
        try {
            return AppUpdateSetting::where('group', 'app_updates')
                ->where('key', 'latest_update')
                ->latest()
                ->get()
                ->map(fn(AppUpdateSetting $setting) => $this->format($setting))
                ->values()
                ->all();
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    public function first(): ?array
    {
        $setting = AppUpdateSetting::where('group', 'app_updates')
            ->where('key', 'latest_update')
            ->latest()
            ->first();

        return $setting ? $this->format($setting) : null;
    }

    /**
     * @throws Exception
     */
    public function store(Request $request): array
    {
        try {
            $setting = AppUpdateSetting::create([
                'group'   => 'app_updates',
                'key'     => 'latest_update',
                'payload' => $this->payload($request),
            ]);

            if ($request->hasFile('image')) {
                $setting->addMediaFromRequest('image')->toMediaCollection('app-update-image');
            }

            return $this->format($setting);
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    public function update(Request $request, AppUpdateSetting $setting): array
    {
        try {
            $setting->payload = $this->payload($request);
            $setting->save();

            if ($request->hasFile('image')) {
                $setting->clearMediaCollection('app-update-image');
                $setting->addMediaFromRequest('image')->toMediaCollection('app-update-image');
            }

            return $this->format($setting);
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    public function destroy(AppUpdateSetting $setting): void
    {
        try {
            $setting->clearMediaCollection('app-update-image');
            $setting->delete();
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    private function payload(Request $request): array
    {
        return [
                'heading'            => $request->input('heading', ''),
                'description'        => $request->input('description', ''),
                'button_one_enabled' => $request->boolean('button_one_enabled'),
                'button_one_text'    => $request->input('button_one_text', ''),
                'button_one_link'    => $request->input('button_one_link', ''),
                'button_two_enabled' => $request->boolean('button_two_enabled'),
                'button_two_text'    => $request->input('button_two_text', ''),
                'button_two_link'    => $request->input('button_two_link', ''),
        ];
    }

    private function format(AppUpdateSetting $setting): array
    {
        $payload = array_merge($this->defaultPayload(), $setting->payload ?? []);

        return array_merge($payload, [
            'id'         => $setting->id,
            'image_url'  => $setting->image_url,
            'created_at' => optional($setting->created_at)->toDateTimeString(),
            'updated_at' => optional($setting->updated_at)->toDateTimeString(),
        ]);
    }
}
