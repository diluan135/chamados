<?php

use App\Http\Controllers\Api\ChamadoController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;


Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('chamados', ChamadoController::class);
    // Rotas para categorias e situações, se necessário
});

Route::post('/login', [AuthController::class, 'login']);

// Rota protegida (exemplo de logout)
Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);