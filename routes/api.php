<?php

use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JWTController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('signup', [UserController::class, 'signup']);
Route::post('login', [UserController::class, 'login']);
Route::post('product/create', [ProductController::class, 'create']);
Route::group(['middleware' => ['jwt.verify']], function () {
    Route::get('/users/me', [UserController::class, 'me']);
    Route::post('/users/update', [ProductController::class, 'updateUser']);
    Route::group(['prefix' => 'product'], function () {
        Route::get('get', [ProductController::class, 'get']);
        Route::post('checkout', [ProductController::class, 'checkout']);
        Route::get('getPurchases', [ProductController::class, 'getPurchases']);
    });
    Route::group(['prefix' => 'admin'], function () {
        Route::get('getUserList', [AdminController::class, 'getUserList']);
        Route::post('accessCancel', [AdminController::class, 'accessCancel']);
    });
});

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});