<?php

namespace App\Http\Controllers\Admin;

use App\Http\Resources\SimpleItemResource;
use App\Models\Item;
use App\Services\TodaySpecialService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class TodaySpecialController extends AdminController implements HasMiddleware
{
    public function __construct(private readonly TodaySpecialService $todaySpecialService)
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
            $selectedItemId = $this->todaySpecialService->getSelectedItemId();
            $selectedItem   = $selectedItemId ? Item::with('media', 'category', 'offer')->find($selectedItemId) : null;

            return response([
                'status' => true,
                'data'   => [
                    'item_id' => $selectedItemId,
                    'item'    => $selectedItem ? new SimpleItemResource($selectedItem) : null,
                ],
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function update(Request $request)
    {
        $request->validate([
            'item_id' => ['required', 'integer', 'exists:items,id'],
        ]);

        try {
            $selected = $this->todaySpecialService->setSelectedItemId((int) $request->input('item_id'));

            return response([
                'status'  => true,
                'message' => 'Today special updated successfully.',
                'data'    => [
                    'item_id' => $selected['item_id'],
                    'item'    => new SimpleItemResource($selected['item']),
                ],
            ]);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }
}
