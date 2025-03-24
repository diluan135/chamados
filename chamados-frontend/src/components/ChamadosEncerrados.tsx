"use client";
import React, { useEffect, useState } from "react";
import axios from "axios";

interface Situacao {
  id: number;
  nome: string;
}

interface Chamado {
  id: number;
  titulo: string;
  descricao: string;
  prazo_solucao: string; // formato de data (YYYY-MM-DD)
  id_situacao: number;
  situacao: Situacao;
  data_criacao: string;
  data_solucao: string; // data de solução
  id_autor: number;
  autor?: {
    name: string;
    email: string;
  };
  // Aqui esperamos que o backend retorne os dados do usuário que solucionou
  solucionador?: {
    name: string;
    email: string;
  };
}

interface User {
  id: number;
  roles: string[];
}

export default function ChamadosEncerrados() {
  const [chamados, setChamados] = useState<Chamado[]>([]);
  const [selectedChamado, setSelectedChamado] = useState<Chamado | null>(null);
  const [user, setUser] = useState<User | null>(null);

  // Carrega o usuário do localStorage
  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
  }, []);

  useEffect(() => {
    if (user && user.roles.includes("administrador")) {
      fetchChamadosEncerrados();
    }
  }, [user]);

  const fetchChamadosEncerrados = async () => {
    try {
      const response = await axios.get("http://localhost:8000/api/chamados", {
        withCredentials: true,
      });
      // Filtra os chamados encerrados, onde id_situacao === 3
      const encerrados = response.data.filter((ch: Chamado) => ch.id_situacao === 3);
      setChamados(encerrados);
    } catch (error) {
      console.error("Erro ao buscar chamados encerrados:", error);
    }
  };

  // Calcula a diferença entre data de criação e data de solução
  const getTimeUntilSolution = (dataCriacao: string, dataSolucao: string): string => {
    const start = new Date(dataCriacao);
    const end = new Date(dataSolucao);
    const diffMs = end.getTime() - start.getTime();
    const totalHours = diffMs / (1000 * 3600);

    if (totalHours < 24) {
      return `${Math.round(totalHours)} Horas`;
    } else {
      const days = Math.floor(totalHours / 24);
      const hours = Math.round(totalHours % 24);
      return `${days} Dias e ${hours} Horas`;
    }
  };

  return (
    <div className="flex h-screen">
      {/* Coluna da esquerda: lista de chamados encerrados */}
      <div className="w-1/2 border-r p-4 overflow-auto">
        <h2 className="text-2xl font-bold mb-4">Chamados Encerrados</h2>
        {chamados.length === 0 ? (
          <p>Sem chamados encerrados</p>
        ) : (
          <ul>
            {chamados.map((ch) => (
              <li
                key={ch.id}
                className="p-2 mb-2 cursor-pointer bg-gray-300 hover:bg-gray-400 cursor-pointer"
                onClick={() => setSelectedChamado(ch)}
              >
                <div className="font-semibold">{ch.titulo}</div>
                <div>{ch.situacao?.nome}</div>
                <div className="text-sm">Prazo: {ch.prazo_solucao}</div>
              </li>
            ))}
          </ul>
        )}
      </div>

      {/* Coluna da direita: detalhes do chamado encerrado */}
      <div className="w-1/2 p-4 overflow-auto">
        {selectedChamado ? (
          <div>
            <h2 className="text-2xl font-bold mb-2">{selectedChamado.titulo}</h2>
            <p>
              <strong>Autor:</strong>{" "}
              {selectedChamado.autor
                ? `${selectedChamado.autor.name} (${selectedChamado.autor.email})`
                : "N/D"}
            </p>
            <p>
              <strong>Situação:</strong> {selectedChamado.situacao?.nome}
            </p>
            <p>
              <strong>Data de criação:</strong> {selectedChamado.data_criacao}
            </p>
            <p>
              <strong>Prazo de solução:</strong> {selectedChamado.prazo_solucao}
            </p>
            <p>
              <strong>Descrição:</strong> {selectedChamado.descricao}
            </p>
            <p>
              <strong>Solucionado por:</strong>{" "}
              {selectedChamado.solucionador
                ? `${selectedChamado.solucionador.name} (${selectedChamado.solucionador.email})`
                : "N/D"}
            </p>
            <p>
              <strong>Data de solução:</strong> {selectedChamado.data_solucao}
            </p>
            <p>
              <strong>Tempo até solução:</strong>{" "}
              {selectedChamado.data_solucao
                ? getTimeUntilSolution(
                    selectedChamado.data_criacao,
                    selectedChamado.data_solucao
                  )
                : "N/D"}
            </p>
          </div>
        ) : (
          <p>Nenhum chamado selecionado</p>
        )}
      </div>
    </div>
  );
}
