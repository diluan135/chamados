<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CategoriaController;
use App\Http\Controllers\Api\ChamadoController;
use App\Http\Controllers\Api\SituacoesController;

// Rotas públicas
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

// Rotas protegidas
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::apiResource('chamados', ChamadoController::class);

    Route::delete('chamados/delete/{id}', [ChamadoController::class, 'destroy']);
    Route::put('chamados/{id}', [ChamadoController::class, 'update']);

    Route::get('categorias', [CategoriaController::class, 'index']);
    
    Route::get('situacoes', [SituacoesController::class, 'index']);
});
