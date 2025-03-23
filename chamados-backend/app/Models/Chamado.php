<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Chamado extends Model
{
    use HasFactory;

    protected $fillable = [
        'titulo', 'descricao', 'prazo_solucao', 'situacao',
        'data_criacao', 'data_solucao', 'categoria_id', 'autor_id', 'atendente_id'
    ];

    protected $casts = [
        'data_criacao' => 'datetime',
        'data_solucao' => 'datetime',
        'prazo_solucao' => 'datetime'
    ];

    // Relações
    public function categoria(): BelongsTo
    {
        return $this->belongsTo(Categoria::class);
    }

    public function autor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'autor_id');
    }

    public function atendente(): BelongsTo
    {
        return $this->belongsTo(User::class, 'atendente_id');
    }
}
