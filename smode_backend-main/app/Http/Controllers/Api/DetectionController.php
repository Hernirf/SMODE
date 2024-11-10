<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Detection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class DetectionController extends Controller
{
    public function list(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        $detections = Detection::select('created_at' , 'message')->where('vehicle_id', $request->id)->get();

        return response()->json($detections);
    }
}
