<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class AppDesignSetting extends Model implements HasMedia
{
    use InteractsWithMedia;

    protected $table = "settings";

    protected $fillable = [
        'group',
        'key',
        'payload',
    ];

    protected $casts = [
        'payload' => 'array',
    ];

    public function getBannerOneUrlAttribute(): ?string
    {
        $url = $this->getFirstMediaUrl('app-banner-1');

        return $url ? asset($url) : null;
    }

    public function getBannerTwoUrlAttribute(): ?string
    {
        $url = $this->getFirstMediaUrl('app-banner-2');

        return $url ? asset($url) : null;
    }
}
