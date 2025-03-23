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
    public function index()
    {
        $chamados = Chamado::with(['categoria', 'situacao', 'autor', 'solucionador'])->get();
        return response()->json($chamados);
    }


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

    public function destroy($id)
    {
        $chamado = Chamado::findOrFail($id);
        $chamado->delete();
        return response()->json(null, 204);
    }

    public function update(Request $request, $id)
    {
        $chamado = Chamado::findOrFail($id);

        // Atualiza os campos normais
        $chamado->fill($request->all());

        // Se a situação for 3 (Encerrado), define a data e o autor da solução
        if ($request->id_situacao == 3) {
            $chamado->data_solucao = now();
            $chamado->id_autor_solucao = auth()->id(); // Pegando o ID do usuário autenticado
        }

        $chamado->save();

        return response()->json($chamado);
    }
}
