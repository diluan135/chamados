<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Situacao;
use Illuminate\Http\Request;

class SituacoesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categorias = Situacao::all();
        return response()->json($categorias);
    }
}
