<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
           'token' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        DB::beginTransaction();
        try {
            $user = auth()->user();

            User::where('id', $user->id)->update([
                'token' => $request->token,
            ]);

            DB::commit();
            return response(['message' => 'User updated successfully']);
        } catch (\Throwable $th) {
            DB::rollback();
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }
}
