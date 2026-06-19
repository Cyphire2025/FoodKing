<?php

namespace App\Services;

use App\Enums\Status;
use App\Libraries\QueryExceptionLibrary;
use App\Models\Item;
use Dipokhalder\Settings\Facades\Settings;
use Exception;
use Illuminate\Support\Facades\Log;

class TodaySpecialService
{
    public function getSelectedItemId(): ?int
    {
        $itemId = Settings::group('today_special')->get('item_id');

        return $itemId ? (int) $itemId : null;
    }

    /**
     * @throws Exception
     */
    public function setSelectedItemId(int $itemId): array
    {
        try {
            $item = Item::where('status', Status::ACTIVE)->findOrFail($itemId);
            Settings::group('today_special')->set(['item_id' => $item->id]);

            return [
                'item_id' => $item->id,
                'item'    => $item->load('media', 'category', 'offer'),
            ];
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }

    /**
     * @throws Exception
     */
    public function getSelectedItem(): ?Item
    {
        try {
            $itemId = $this->getSelectedItemId();

            if (!$itemId) {
                return null;
            }

            return Item::with('media', 'category', 'offer')
                ->where([
                    'id'     => $itemId,
                    'status' => Status::ACTIVE,
                ])->first();
        } catch (Exception $exception) {
            Log::info($exception->getMessage());
            throw new Exception(QueryExceptionLibrary::message($exception), 422);
        }
    }
}
