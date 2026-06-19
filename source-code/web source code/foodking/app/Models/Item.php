<?php

namespace App\Models;

use Carbon\Carbon;
use App\Enums\Status;
use Spatie\MediaLibrary\HasMedia;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\InteractsWithMedia;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Spatie\MediaLibrary\MediaCollections\Models\Media;

class Item extends Model implements HasMedia
{
    use HasFactory, InteractsWithMedia, SoftDeletes;

    protected $table = "items";
    protected $fillable = [
        'name',
        'item_category_id',
        'slug',
        'tax_id',
        'item_type',
        'price',
        'size',
        'calories',
        'is_featured',
        'description',
        'caution',
        'status',
        'order',
    ];
    protected $dates = ['deleted_at'];
    protected $casts = [
        'id'               => 'integer',
        'name'             => 'string',
        'item_category_id' => 'integer',
        'slug'             => 'string',
        'tax_id'           => 'integer',
        'item_type'        => 'integer',
        'price'            => 'decimal:6',
        'size'             => 'string',
        'calories'         => 'integer',
        'is_featured'      => 'integer',
        'description'      => 'string',
        'caution'          => 'string',
        'status'           => 'integer',
        'order'            => 'integer',
    ];

    public function getThumbAttribute(): string
    {
        if (!empty($this->getFirstMediaUrl('item'))) {
            $item = $this->getMedia('item')->last();
            return $this->safeMediaUrl($item->getUrl('thumb'));
        }
        return asset('images/item/thumb.png');
    }

    public function getCoverAttribute(): string
    {
        if (!empty($this->getFirstMediaUrl('item'))) {
            $item = $this->getMedia('item')->last();
            return $this->safeMediaUrl($item->getUrl('cover'));
        }
        return asset('images/item/cover.png');
    }

    public function getPreviewAttribute(): string
    {
        if (!empty($this->getFirstMediaUrl('item'))) {
            $item = $this->getMedia('item')->last();
            return $this->safeMediaUrl($item->getUrl('preview'));
        }
        return asset('images/item/cover.png');
    }

    private function safeMediaUrl(string $url): string
    {
        return str_replace(['(', ')', ' '], ['%28', '%29', '%20'], $url);
    }

    public function registerMediaConversions(?Media $media = null): void
    {
        $this->addMediaConversion('thumb')->width(168)->height(180)->keepOriginalImageFormat()->sharpen(10);
        $this->addMediaConversion('cover')->width(390)->height(270)->keepOriginalImageFormat()->sharpen(10);
        $this->addMediaConversion('preview')->width(600)->height(600)->keepOriginalImageFormat()->sharpen(10);
    }

    public function variations(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(ItemVariation::class)->with('itemAttribute')->where(['status' => Status::ACTIVE]);
    }

    public function extras(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(ItemExtra::class)->where(['status' => Status::ACTIVE]);
    }

    public function addons(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(ItemAddon::class);
    }

    public function category(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(ItemCategory::class, 'item_category_id', 'id');
    }

    public function tax(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(Tax::class);
    }

    public function orders(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(OrderItem::class, 'item_id', 'id');
    }

    public function offer(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(Offer::class, 'offer_items');
    }
}
