<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Situacao extends Model
{
    // Define o nome da tabela explicitamente
    protected $table = 'situacoes';

    protected $fillable = [
        'nome',
    ];
}
