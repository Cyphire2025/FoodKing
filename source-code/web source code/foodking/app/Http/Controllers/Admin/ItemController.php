<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\DB;
use Exception;
use App\Models\Item;
use App\Exports\ItemExport;
use App\Imports\ItemImport;
use App\Services\ItemService;
use App\Http\Requests\ItemRequest;
use App\Http\Resources\ItemResource;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Requests\PaginateRequest;
use App\Http\Requests\ItemImportRequest;
use App\Http\Requests\ChangeImageRequest;
use App\Http\Resources\NormalItemResource;
use App\Http\Resources\SimpleItemResource;
use Illuminate\Routing\Controllers\Middleware;
use Illuminate\Routing\Controllers\HasMiddleware;

class ItemController extends AdminController implements HasMiddleware
{
    public ItemService $itemService;

    public function __construct(ItemService $itemService)
    {
        parent::__construct();
        $this->itemService = $itemService;
    }

    public static function middleware(): array
    {
        return [
            new Middleware('permission:items', only: ['export']),
            new Middleware('permission:items', only: ['changeImage']),
            new Middleware('permission:items_create', only: ['store']),
            new Middleware('permission:items_create', only: ['import']),
            new Middleware('permission:items_edit', only: ['update']),
            new Middleware('permission:items_delete', only: ['destroy']),
            new Middleware('permission:items_show', only: ['show']),
        ];
    }

    public function index(PaginateRequest $request) : \Illuminate\Http\Response | \Illuminate\Http\Resources\Json\AnonymousResourceCollection | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            return SimpleItemResource::collection($this->itemService->simpleList($request));
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }


    public function show(Item $item) : \Illuminate\Http\Response | ItemResource | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            return new ItemResource($this->itemService->show($item));
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function store(ItemRequest $request) : \Illuminate\Http\Response | ItemResource | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            if (env('DEMO')) {
                $item = $this->itemService->store($request);
                $this->persistCustomItemFields($request, $item);
                return new ItemResource($item->refresh());
            } else {
                    $item = $this->itemService->store($request);
                    $this->persistCustomItemFields($request, $item);
                    return new ItemResource($item->refresh());
            }
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function update(ItemRequest $request, Item $item) : \Illuminate\Http\Response | ItemResource | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            $updatedItem = $this->itemService->update($request, $item);
            $this->persistCustomItemFields($request, $updatedItem);
            return new ItemResource($updatedItem->refresh());
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function destroy(Item $item) : \Illuminate\Http\Response | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            $this->itemService->destroy($item);
            return response('', 202);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function changeImage(ChangeImageRequest $request, Item $item) : \Illuminate\Http\Response | ItemResource | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            return new ItemResource($this->itemService->changeImage($request, $item));
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function export(PaginateRequest $request) : \Illuminate\Http\Response | \Symfony\Component\HttpFoundation\BinaryFileResponse | \Illuminate\Contracts\Foundation\Application | \Illuminate\Contracts\Routing\ResponseFactory
    {
        try {
            return Excel::download(new ItemExport($this->itemService, $request), 'Item.xlsx');
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function downloadSample()
    {
        try {
            return Response::download(public_path('/file/itemImportSample.xlsx'));
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function import(ItemImportRequest $request)
    {
        try {
            Excel::import(new ItemImport($request->file('file')), $request->file('file'));
            return response('', 202);
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    public function itemDetails(Item $item)
    {
        try {
           return new NormalItemResource($this->itemService->itemDetails($item));
        } catch (Exception $exception) {
            return response(['status' => false, 'message' => $exception->getMessage()], 422);
        }
    }

    private function persistCustomItemFields(ItemRequest $request, Item $item): void
    {
        $payload = [
            'size'       => $request->filled('size') ? $request->input('size') : null,
            'calories'   => $request->filled('calories') ? (int) $request->input('calories') : null,
            'updated_at' => now(),
        ];

        $item->forceFill($payload)->save();
        DB::table('items')->where('id', $item->id)->update($payload);
    }
}
