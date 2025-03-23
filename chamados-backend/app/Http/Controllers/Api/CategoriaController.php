<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Categoria; // Certifique-se de que o model existe
use Illuminate\Http\Request;

class CategoriaController extends Controller
{
    // Retorna todas as categorias
    public function index()
    {
        $categorias = Categoria::all();
        return response()->json($categorias);
    }
}
