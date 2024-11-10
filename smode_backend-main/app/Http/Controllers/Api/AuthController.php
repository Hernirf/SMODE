<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        $validator = Validator::make($credentials, [
            'email' => 'required|email',
            'password' => 'required|string|min:8'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        try {
            $token = JWTAuth::attempt($credentials);
            
            if (!$token) {
                return response()->json(['message' => 'Login credentials are invalid'], 400);
            }

            $userResponse = User::select('email')->where('email', $request->email)->first();
            $userResponse->token = $token;

            return response()->json($userResponse);

        } catch (JWTException $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function logout()
    {
        auth()->logout();

        return response()->json(['message' => 'Logout success']);
    }
}
