<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Chamado extends Model
{
    use HasFactory;

    protected $fillable = [
        'titulo',
        'id_categoria',
        'descricao',
        'prazo_solucao',
        'id_situacao',
        'data_criacao',
        'id_autor',
        'data_solucao',
        'id_autor_solucao',
    ];
    public function categoria()
    {
        return $this->belongsTo(Categoria::class, 'id_categoria');
    }

    public function situacao()
    {
        return $this->belongsTo(Situacao::class, 'id_situacao');
    }

    public function autor()
    {
        return $this->belongsTo(User::class, 'id_autor');
    }

    public function solucionador()
    {
        return $this->belongsTo(User::class, 'id_autor_solucao');
    }
}
