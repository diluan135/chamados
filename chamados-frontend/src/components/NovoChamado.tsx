"use client";
import React, { useEffect, useState } from "react";
import axios from "axios";

export default function NovoChamado() {
  const [titulo, setTitulo] = useState("");
  const [descricao, setDescricao] = useState("");
  const [categoriaSelecionada, setCategoriaSelecionada] = useState("");
  const [categorias, setCategorias] = useState<any[]>([]);

  useEffect(() => {
    const fetchCategorias = async () => {
      try {
        const response = await axios.get("http://localhost:8000/api/categorias", {
          withCredentials: true,
        });
        setCategorias(response.data);
      } catch (error) {
        console.error("Erro ao buscar categorias:", error.response?.data || error.message);
      }
    };
    fetchCategorias();
  }, []);

  const handleSubmit = async () => {
    try {
      await axios.post(
        "http://localhost:8000/api/chamados",
        {
          titulo,
          descricao,
          id_categoria: categoriaSelecionada,
        },
        { withCredentials: true }
      );
      setTitulo("");
      setDescricao("");
      setCategoriaSelecionada("");
      alert("Chamado criado com sucesso!");
    } catch (error: any) {
      console.error("Erro ao criar chamado:", error.response?.data || error.message);
    }
  };

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Novo Chamado</h2>
      <div className="mb-4">
        <input
          type="text"
          placeholder="Título"
          value={titulo}
          onChange={(e) => setTitulo(e.target.value)}
          className="border p-2 w-full"
        />
      </div>
      <div className="mb-4">
        <input
          type="text"
          placeholder="Descrição"
          value={descricao}
          onChange={(e) => setDescricao(e.target.value)}
          className="border p-2 w-full"
        />
      </div>
      <div className="mb-4">
        <select
          value={categoriaSelecionada}
          onChange={(e) => setCategoriaSelecionada(e.target.value)}
          className="border p-2 w-full"
        >
          <option value="">Selecione a categoria</option>
          {categorias.map((cat) => (
            <option key={cat.id} value={cat.id}>
              {cat.nome}
            </option>
          ))}
        </select>
      </div>
      <button onClick={handleSubmit} className="bg-blue-500 text-white p-2 rounded">
        Criar Chamado
      </button>
    </div>
  );
}
