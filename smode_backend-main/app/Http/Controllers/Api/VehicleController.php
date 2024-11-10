<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Vehicle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\DB;
use \PhpMqtt\Client\MqttClient;
use \PhpMqtt\Client\ConnectionSettings;

class VehicleController extends Controller
{

    // public function conect()
    // {

    // }

    public function list()
    {
        $user = auth()->user();

        $vehicles = Vehicle::select('id', 'merk', 'plate', 'image', 'mode_aman', 'mode_mesin')->where('owner_id', $user->id)->get();

        foreach ($vehicles as $vehicle) {
            $vehicle->image = url('storage/vehicles/'.$vehicle->image);
        }

        return response()->json($vehicles);
    }

    public function modeaman(Request $request)
    {
        $server   = 'nae2e62a.ala.asia-southeast1.emqxsl.com';
        $port     = 8883;
        $clientId = 'SMODE PHP';
        $username = 'smode';
        $password = '12345678';
        $clean_session = false;

        $connectionSettings  = (new ConnectionSettings)
        ->setUsername($username)
        ->setPassword($password)
        ->setKeepAliveInterval(60)
        ->setConnectTimeout(3)
        ->setUseTls(true)
        ->setTlsSelfSignedAllowed(true);

        $mqtt = new MqttClient($server, $port, $clientId, MqttClient::MQTT_3_1_1);
        $mqtt->connect($connectionSettings, $clean_session);

        $validator = Validator::make($request->all(), [
           'id' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        $user = auth()->user();

        $isExist = Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->exists();

        if (!$isExist) {
            return response()->json(['message' => 'Vehicle not found'], 404);
        }

        DB::beginTransaction();
        try {
            $vehicle = Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->first();

            if ($vehicle->mode_aman == 0) {
                $modeaman = 1;
            } else {
                $modeaman = 0;
            }

            $topic = 'vehicle/aman/' . $request->id;

            $mqtt->publish($topic, $modeaman, 0);

            Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->update([
                'mode_aman' => $modeaman,
            ]);

            DB::commit();
            return response(['message' => 'Mode Aman updated successfully']);
        } catch (\Throwable $th) {
            DB::rollback();
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }

    public function modemesin(Request $request)
    {
        $server   = 'nae2e62a.ala.asia-southeast1.emqxsl.com';
        $port     = 8883;
        $clientId = 'SMODE PHP';
        $username = 'smode';
        $password = '12345678';
        $clean_session = false;

        $connectionSettings  = (new ConnectionSettings)
        ->setUsername($username)
        ->setPassword($password)
        ->setKeepAliveInterval(60)
        ->setConnectTimeout(3)
        ->setUseTls(true)
        ->setTlsSelfSignedAllowed(true);

        $mqtt = new MqttClient($server, $port, $clientId, MqttClient::MQTT_3_1_1);
        $mqtt->connect($connectionSettings, $clean_session);

        $validator = Validator::make($request->all(), [
           'id' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        $user = auth()->user();

        $isExist = Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->exists();

        if (!$isExist) {
            return response()->json(['message' => 'Vehicle not found'], 404);
        }

        DB::beginTransaction();
        try {
            $vehicle = Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->first();

            if ($vehicle->mode_mesin == 0) {
                $modemesin = 1;
            } else {
                $modemesin = 0;
            }

            $topic = 'vehicle/mesin/' . $request->id;

            // MQTT::publish($topic, $modemesin);
            $mqtt->publish($topic, $modemesin, 0);

            Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->update([
                'mode_mesin' => $modemesin,
            ]);

            DB::commit();
            return response(['message' => 'Mode Mesin updated successfully']);
        } catch (\Throwable $th) {
            DB::rollback();
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }

    public function location(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->messages()], 400);
        }

        $user = auth()->user();

        $isExist = Vehicle::where(['id' => $request->id, 'owner_id' => $user->id])->exists();

        if (!$isExist) {
            return response()->json(['message' => 'Vehicle not found'], 404);
        }

        $vehicle = Vehicle::select('lat', 'lon')->where(['id' => $request->id, 'owner_id' => $user->id])->first();

        return response()->json($vehicle);
    }
}
