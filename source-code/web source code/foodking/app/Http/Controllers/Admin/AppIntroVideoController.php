<?php

namespace App\Http\Controllers\Admin;

use App\Services\AppIntroVideoService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class AppIntroVideoController extends AdminController implements HasMiddleware
{
    public function __construct(private readonly AppIntroVideoService $appIntroVideoService)
    {
        parent::__construct();
    }

    public static function middleware(): array
    {
        return [
            new Middleware('permission:settings', only: ['index', 'update']),
        ];
    }

    public function index()
    {
        try {
            return response([
                'status' => true,
                'data'   => $this->appIntroVideoService->list(),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function update(Request $request)
    {
        $request->validate([
            'app_intro_media' => ['required', 'file', 'mimes:jpg,jpeg,png,gif,webp,mp4,mov,webm,avi,mkv', 'max:51200'],
        ]);

        try {
            return response([
                'status'  => true,
                'message' => 'App intro media updated successfully.',
                'data'    => $this->appIntroVideoService->update($request),
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }
}
