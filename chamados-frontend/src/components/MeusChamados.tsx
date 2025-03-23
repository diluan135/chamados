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
    id_autor: number;
    autor?: {
        name: string;
        email: string;
    };
}

interface User {
    id: number;
    roles: string[];
}

export default function MeusChamados() {
    const [chamados, setChamados] = useState<Chamado[]>([]);
    const [selectedChamado, setSelectedChamado] = useState<Chamado | null>(null);
    const [situacoes, setSituacoes] = useState<Situacao[]>([]);
    const [newSituacao, setNewSituacao] = useState<number | null>(null);
    const [user, setUser] = useState<User | null>(null);

    // Carrega o usuário do localStorage
    useEffect(() => {
        const storedUser = localStorage.getItem("user");
        if (storedUser) {
            setUser(JSON.parse(storedUser));
        }
    }, []);

    // Quando o usuário estiver carregado, busque os chamados e situações
    useEffect(() => {
        if (user) {
            fetchChamados();
            fetchSituacoes();
        }
    }, [user]);

    // Função para buscar chamados e filtrar conforme a role do usuário
    const fetchChamados = async () => {
        try {
            const response = await axios.get("http://localhost:8000/api/chamados", {
                withCredentials: true,
            });
            let allChamados: Chamado[] = response.data;

            if (user) {
                if (user.roles.includes("administrador")) {
                    // Administrador: pega chamados que não estão resolvidos (id_situacao !== 3)
                    allChamados = allChamados.filter((ch) => ch.id_situacao !== 3);
                } else {
                    // Outros: pega apenas os chamados do próprio usuário
                    allChamados = allChamados.filter((ch) => ch.id_autor === user.id);
                }
            }
            setChamados(allChamados);
        } catch (error) {
            console.error("Erro ao buscar chamados:", error);
        }
    };

    // Função para buscar as situações (usada para o dropdown no admin)
    const fetchSituacoes = async () => {
        try {
            const response = await axios.get("http://localhost:8000/api/situacoes", {
                withCredentials: true,
            });
            setSituacoes(response.data);
        } catch (error) {
            console.error("Erro ao buscar situacoes:", error);
        }
    };

    // Calcula o background do item de chamado baseado no prazo
    const getBackgroundColor = (prazo: string) => {
        const prazoDate = new Date(prazo);
        const currentDate = new Date();
        const diffTime = prazoDate.getTime() - currentDate.getTime();
        const diffDays = diffTime / (1000 * 3600 * 24);

        if (diffDays < 0) {
            return "bg-red-300"; // prazo expirado
        } else if (diffDays <= 2) {
            return "bg-orange-300"; // prazo próximo (até 2 dias)
        } else {
            return "bg-green-300"; // prazo seguro (3 dias ou mais)
        }
    };

    const handleDeleteChamado = async (chamadoId: number) => {
        try {
            await axios.delete(`http://localhost:8000/api/chamados/delete/${chamadoId}`, {
                withCredentials: true,
            });
            setSelectedChamado(null);
            fetchChamados();
        } catch (error) {
            console.error("Erro ao excluir chamado:", error);
        }
    };

    const handleSaveSituacao = async () => {
        if (!selectedChamado || newSituacao === null) return;
        try {
            await axios.put(
                `http://localhost:8000/api/chamados/${selectedChamado.id}`,
                {
                    id_situacao: newSituacao,
                    id_autor_solucao: user?.id // Passa o ID do usuário logado
                },
                { withCredentials: true }
            );
            // Atualiza a lista e o chamado selecionado
            fetchChamados();
            setSelectedChamado({
                ...selectedChamado,
                id_situacao: newSituacao,
                situacao:
                    situacoes.find((s) => s.id === newSituacao) || selectedChamado.situacao,
            });
            setSelectedChamado(null);
        } catch (error) {
            console.error("Erro ao atualizar situacao:", error);
        }
    };

    return (
        <div className="flex h-screen">
            {/* Coluna da esquerda: lista de chamados */}
            <div className="w-1/2 border-r p-4 overflow-auto">
                <h2 className="text-2xl font-bold mb-4">Chamados</h2>
                {chamados.length === 0 ? (
                    <p>Sem chamados</p>
                ) : (
                    <ul>
                        {chamados.map((ch) => (
                            <li
                                key={ch.id}
                                className={`p-2 mb-2 cursor-pointer ${getBackgroundColor(
                                    ch.prazo_solucao
                                )}`}
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

            {/* Coluna da direita: detalhes do chamado */}
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
                        <button
                            onClick={() => handleDeleteChamado(selectedChamado.id)}
                            className="bg-red-500 text-white p-2 rounded mt-4 block"
                        >
                            Excluir Chamado
                        </button>
                        {/* Se o usuário for administrador, permite alterar a situação */}
                        {user && user.roles.includes("administrador") && (
                            <div className="mt-4">
                                <label className="block mb-1">Alterar Situação:</label>
                                <select
                                    value={newSituacao ?? selectedChamado.id_situacao}
                                    onChange={(e) =>
                                        setNewSituacao(parseInt(e.target.value, 10))
                                    }
                                    className="border p-2"
                                >
                                    {situacoes.map((s) => (
                                        <option key={s.id} value={s.id}>
                                            {s.nome}
                                        </option>
                                    ))}
                                </select>
                                <button
                                    onClick={handleSaveSituacao}
                                    className="bg-blue-500 text-white p-2 rounded ml-2"
                                >
                                    Salvar
                                </button>
                            </div>
                        )}
                    </div>
                ) : (
                    <p>Nenhum chamado selecionado</p>
                )}
            </div>
        </div>
    );
}
