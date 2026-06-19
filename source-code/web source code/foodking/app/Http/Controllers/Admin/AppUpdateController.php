<?php

namespace App\Http\Controllers\Admin;

use App\Models\AppUpdateSetting;
use App\Services\AppUpdateService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class AppUpdateController extends AdminController implements HasMiddleware
{
    public function __construct(private readonly AppUpdateService $appUpdateService)
    {
        parent::__construct();
    }

    public static function middleware(): array
    {
        return [
            new Middleware('permission:settings', only: ['index', 'store', 'update', 'destroy']),
        ];
    }

    public function index()
    {
        try {
            return response([
                'status' => true,
                'data'   => $this->appUpdateService->list(),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function store(Request $request)
    {
        $this->validateRequest($request);

        try {
            return response([
                'status'  => true,
                'message' => 'App update created successfully.',
                'data'    => $this->appUpdateService->store($request),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function update(Request $request, AppUpdateSetting $appUpdateSetting)
    {
        $this->validateRequest($request);

        try {
            return response([
                'status'  => true,
                'message' => 'App update updated successfully.',
                'data'    => $this->appUpdateService->update($request, $appUpdateSetting),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function destroy(AppUpdateSetting $appUpdateSetting)
    {
        try {
            $this->appUpdateService->destroy($appUpdateSetting);

            return response([
                'status'  => true,
                'message' => 'App update deleted successfully.',
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    private function validateRequest(Request $request): void
    {
        $request->validate([
            'image'              => ['nullable', 'image', 'mimes:jpg,jpeg,png,gif,webp', 'max:5120'],
            'heading'            => ['nullable', 'string', 'max:160'],
            'description'        => ['nullable', 'string', 'max:1000'],
            'button_one_enabled' => ['nullable', 'boolean'],
            'button_one_text'    => ['nullable', 'string', 'max:80'],
            'button_one_link'    => ['nullable', 'url', 'max:500'],
            'button_two_enabled' => ['nullable', 'boolean'],
            'button_two_text'    => ['nullable', 'string', 'max:80'],
            'button_two_link'    => ['nullable', 'url', 'max:500'],
        ]);
    }
}
