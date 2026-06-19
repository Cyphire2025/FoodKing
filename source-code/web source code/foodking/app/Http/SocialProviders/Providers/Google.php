<?php

namespace App\Http\SocialProviders\Providers;

use Exception;
use App\Enums\Ask;
use Carbon\Carbon;
use App\Models\User;
use App\Models\SocialLogin;
use Illuminate\Support\Str;
use App\Services\MenuService;
use App\Services\PermissionService;
use App\Enums\Role as EnumRole;
use Google\Client as GoogleClient;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use App\Services\SocialLoginAbstract;
use Illuminate\Support\Facades\Config;
use Laravel\Socialite\Facades\Socialite;

class Google extends SocialLoginAbstract
{
    public mixed $response;
    private $provider;
    private $gatewayOptions;
    private $email;

    /**
     * @throws \Exception
     */
    public function __construct(MenuService $menuService, PermissionService $permissionService)
    {
        parent::__construct($menuService, $permissionService);
        
        $this->provider = SocialLogin::where(['slug' => 'google'])->first();
        $this->gatewayOptions = $this->provider->gatewayOptions->pluck('value', 'option');
        Config::set('services.google.client_id', $this->gatewayOptions['google_client_id']);
        Config::set('services.google.client_secret', $this->gatewayOptions['google_client_secret']);
        Config::set('services.google.redirect', config('app.url') . '/login/google/callback');
    }

    public function getUrl(): JsonResponse
    {
        try {
            $url = Socialite::driver('google')->stateless()->redirect()->getTargetUrl();
            return new JsonResponse([
                'url' => $url
            ], 200);
        } catch (Exception $exception) {
            return new JsonResponse([
                'errors' => ['server_error' => $exception->getMessage()]
            ], 500);
        }
    }

    public function verifySocialLogin()
    {
        try {
            $socialUser = Socialite::driver('google')->stateless()->user();
            $this->email = $socialUser->getEmail();

            $user = User::where('email', $this->email)->first();
            if (!$user) {
                $user = User::create([
                    'name' => $socialUser->getName(),
                    'username' => Str::slug($socialUser->getName()) . rand(1, 500),
                    'email' => $socialUser->getEmail(),
                    'email_verified_at' => Carbon::now()->getTimestamp(),
                    'is_guest' => Ask::NO,
                    'password' => Hash::make(Str::random(12))
                ]);

                $user->assignRole(EnumRole::CUSTOMER);
            }
            return $this->Login($user);
        } catch (Exception $exception) {
            return new JsonResponse([
            'errors' => ['server_error' => $exception->getMessage()]
        ], 500);
        }
    }

    public function verifyMobileSocialLogin(string $idToken)
    {
        try {
            $client = new GoogleClient([
                'client_id' => $this->gatewayOptions['google_client_id'],
            ]);
            $payload = $client->verifyIdToken($idToken);

            if (!$payload || empty($payload['email'])) {
                return new JsonResponse([
                    'errors' => ['server_error' => trans('auth.failed')]
                ], 422);
            }

            $user = User::where('email', $payload['email'])->first();
            if (!$user) {
                $name = $payload['name'] ?? $payload['email'];
                $user = User::create([
                    'name' => $name,
                    'username' => Str::slug($name) . rand(1, 500),
                    'email' => $payload['email'],
                    'email_verified_at' => Carbon::now()->getTimestamp(),
                    'is_guest' => Ask::NO,
                    'password' => Hash::make(Str::random(12))
                ]);

                $user->assignRole(EnumRole::CUSTOMER);
            }

            return $this->Login($user);
        } catch (Exception $exception) {
            return new JsonResponse([
                'errors' => ['server_error' => $exception->getMessage()]
            ], 500);
        }
    }
}
