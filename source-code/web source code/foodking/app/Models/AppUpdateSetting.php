<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class AppUpdateSetting extends Model implements HasMedia
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

    public function getImageUrlAttribute(): ?string
    {
        $url = $this->getFirstMediaUrl('app-update-image');

        return $url ? asset($url) : null;
    }
}
