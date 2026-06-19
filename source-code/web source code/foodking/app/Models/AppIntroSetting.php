<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class AppIntroSetting extends Model implements HasMedia
{
    use InteractsWithMedia;

    protected $table = "settings";

    protected $fillable = [
        'group',
        'key',
        'payload',
    ];

    public function getMediaUrlAttribute(): ?string
    {
        $url = $this->getFirstMediaUrl('app-intro-media');

        return $url ? asset($url) : null;
    }

    public function getMediaTypeAttribute(): ?string
    {
        $media = $this->getFirstMedia('app-intro-media');

        if (!$media) {
            return null;
        }

        return str_starts_with((string) $media->mime_type, 'image/') ? 'image' : 'video';
    }
}
