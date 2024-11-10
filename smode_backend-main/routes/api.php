<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\DetectionController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\VehicleController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('login', [AuthController::class, 'login']);

Route::group(['middleware' => 'jwt.verify'], function () {
    Route::post('logout', [AuthController::class, 'logout']);

    Route::group(['prefix' => 'vehicle'], function () {
        Route::get('/list', [VehicleController::class, 'list']);
        Route::put('/modeaman', [VehicleController::class, 'modeaman']);
        Route::put('/modemesin', [VehicleController::class, 'modemesin']);
        Route::post('/location', [VehicleController::class, 'location']);
    });

    Route::group(['prefix' => 'detection'], function () {
        Route::post('/list', [DetectionController::class, 'list']);
    });

    Route::group(['prefix' => 'user'], function () {
        Route::put('/update', [UserController::class, 'update']);
    });
});