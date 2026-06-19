<?php

namespace App\Http\Controllers\Admin;

use App\Services\AppDesignService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class AppDesignController extends AdminController implements HasMiddleware
{
    public function __construct(private readonly AppDesignService $appDesignService)
    {
        parent::__construct();
    }

    public static function middleware(): array
    {
        return [
            new Middleware('permission:settings', only: ['index', 'updateColor', 'updateBanners']),
        ];
    }

    public function index()
    {
        try {
            return response([
                'status' => true,
                'data'   => $this->appDesignService->list(),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function updateColor(Request $request)
    {
        $request->validate([
            'primary_color' => ['required', 'regex:/^#[0-9A-Fa-f]{6}$/'],
        ]);

        try {
            return response([
                'status'  => true,
                'message' => 'App color updated successfully.',
                'data'    => $this->appDesignService->updateColor($request),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function updateBanners(Request $request)
    {
        $request->validate([
            'banner_1' => ['nullable', 'image', 'mimes:jpg,jpeg,png,gif,webp', 'max:5120'],
            'banner_2' => ['nullable', 'image', 'mimes:jpg,jpeg,png,gif,webp', 'max:5120'],
        ]);

        try {
            return response([
                'status'  => true,
                'message' => 'App banners updated successfully.',
                'data'    => $this->appDesignService->updateBanners($request),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }
}
