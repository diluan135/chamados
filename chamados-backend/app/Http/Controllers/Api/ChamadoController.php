<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Chamado;
use Illuminate\Http\Request;

class ChamadoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'titulo' => 'required|string',
            'id_categoria' => 'required|exists:categorias,id',
            'descricao' => 'required|string',
            // outros campos conforme necessário
        ]);

        $data['id_situacao'] = 1; // Supondo que 1 seja a situação "Novo"
        $data['data_criacao'] = now();
        $data['prazo_solucao'] = now()->addDays(3);
        $data['id_autor'] = auth()->id(); // ou passar via request, conforme sua autenticação

        $chamado = Chamado::create($data);

        return response()->json($chamado, 201);
    }
}
