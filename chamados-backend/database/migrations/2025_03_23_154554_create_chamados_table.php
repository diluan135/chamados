<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('chamados', function (Blueprint $table) {
            $table->id();
            $table->string('titulo');
            $table->unsignedBigInteger('id_categoria');
            $table->text('descricao');
            $table->date('prazo_solucao'); // será calculado automaticamente
            $table->unsignedBigInteger('id_situacao');
            $table->timestamp('data_criacao')->useCurrent();
            $table->unsignedBigInteger('id_autor');
            $table->date('data_solucao')->nullable();
            $table->unsignedBigInteger('id_autor_solucao')->nullable();
            $table->timestamps();

            $table->foreign('id_categoria')->references('id')->on('categorias');
            $table->foreign('id_situacao')->references('id')->on('situacoes');
            $table->foreign('id_autor')->references('id')->on('users');
            $table->foreign('id_autor_solucao')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('chamados');
    }
};
