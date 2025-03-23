"use client";

import React, { useEffect, useState } from "react";
import axios from "axios";
import {
    PieChart,
    Pie,
    Cell,
    Tooltip,
    Legend,
    BarChart,
    Bar,
    XAxis,
    YAxis,
    CartesianGrid,
} from "recharts";

// Interfaces dos dados
interface Situacao {
    id: number;
    nome: string;
}

interface Chamado {
    id: number;
    titulo: string;
    descricao: string;
    prazo_solucao: string;
    id_situacao: number;
    situacao: Situacao;
    data_criacao: string;
    data_solucao: string | null;
    id_autor: number;
    id_autor_solucao: number | null;
    autor?: {
        name: string;
        email: string;
    };
    solucionador?: {
        name: string;
        email: string;
    };
    // Adicione a propriedade opcional categoria
    categoria?: {
        id: number;
        nome: string;
    };
}


interface PainelMetrics {
    totalChamados: number;
    resolvedChamados: number;
    slaPercent: number;
    // Distribuição por categorias (nome e contagem)
    categoryData: { name: string; value: number }[];
    // Distribuição por situações
    situacaoData: { nome: string; count: number }[];
    // Usuários que mais resolveram
    usuariosResolucao: { name: string; count: number }[];
    // Tempo médio de resolução por usuário (em horas)
    tempoMedioPorUsuario: { name: string; averageHours: number }[];
}

export default function Painel() {
    const [chamados, setChamados] = useState<Chamado[]>([]);
    const [metrics, setMetrics] = useState<PainelMetrics | null>(null);

    useEffect(() => {
        fetchChamados();
    }, []);

    const fetchChamados = async () => {
        try {
            const response = await axios.get("http://localhost:8000/api/chamados", {
                withCredentials: true,
            });
            const data: Chamado[] = response.data;
            setChamados(data);
            processMetrics(data);
        } catch (error) {
            console.error("Erro ao buscar chamados:", error);
        }
    };

    // Processa as métricas a partir dos chamados
    const processMetrics = (data: Chamado[]) => {
        const totalChamados = data.length;
        // Chamados resolvidos são aqueles com id_situacao === 3 e data_solucao preenchida
        const resolvedChamados = data.filter(
            (ch) => ch.id_situacao === 3 && ch.data_solucao
        );
        // Chamados resolvidos dentro do prazo (apenas para o mês atual)
        const currentMonth = new Date().getMonth();
        const resolvedWithinDeadline = resolvedChamados.filter((ch) => {
            const dataSolucao = new Date(ch.data_solucao!);
            const prazoSolucao = new Date(ch.prazo_solucao);
            // Considera apenas chamados do mês atual (de data_criacao)
            const dataCriacao = new Date(ch.data_criacao);
            if (dataCriacao.getMonth() !== currentMonth) return false;
            return dataSolucao.getTime() <= prazoSolucao.getTime();
        });
        const slaPercent =
            resolvedChamados.length > 0
                ? (resolvedWithinDeadline.length / resolvedChamados.length) * 100
                : 0;

        // Distribuição por categorias
        const categoryMap: { [key: string]: number } = {};
        data.forEach((ch) => {
            const catName = ch.categoria ? ch.categoria.nome : "Sem Categoria";
            categoryMap[catName] = (categoryMap[catName] || 0) + 1;
        });
        const categoryData = Object.keys(categoryMap).map((key) => ({
            name: key,
            value: categoryMap[key],
        }));

        // Distribuição por situações
        const situacaoMap: { [key: string]: number } = {};
        data.forEach((ch) => {
            const sitName = ch.situacao ? ch.situacao.nome : "Sem Situação";
            situacaoMap[sitName] = (situacaoMap[sitName] || 0) + 1;
        });
        const situacaoData = Object.keys(situacaoMap).map((key) => ({
            nome: key,
            count: situacaoMap[key],
        }));

        // Usuários que mais resolveram: agrupar por id_autor_solucao
        const usuariosMap: { [key: string]: { count: number; name: string } } = {};
        resolvedChamados.forEach((ch) => {
            if (ch.id_autor_solucao) {
                const userId = ch.id_autor_solucao.toString();
                const nome =
                    ch.solucionador && ch.solucionador.name ? ch.solucionador.name : "Desconhecido";
                if (!usuariosMap[userId]) {
                    usuariosMap[userId] = { count: 0, name: nome };
                }
                usuariosMap[userId].count += 1;
            }
        });
        const usuariosResolucao = Object.keys(usuariosMap).map((key) => ({
            name: usuariosMap[key].name,
            count: usuariosMap[key].count,
        }));
        // Ordena decrescente
        usuariosResolucao.sort((a, b) => b.count - a.count);

        // Tempo médio de resolução por usuário (em horas)
        // Para cada chamado resolvido, calcula a diferença (em horas) entre data_criacao e data_solucao
        const tempoMap: { [key: string]: { totalHours: number; count: number; name: string } } = {};
        resolvedChamados.forEach((ch) => {
            if (ch.id_autor_solucao && ch.data_solucao) {
                const userId = ch.id_autor_solucao.toString();
                const dataCriacao = new Date(ch.data_criacao);
                const dataSolucao = new Date(ch.data_solucao);
                const diffHours = (dataSolucao.getTime() - dataCriacao.getTime()) / (1000 * 3600);
                const nome =
                    ch.solucionador && ch.solucionador.name ? ch.solucionador.name : "Desconhecido";
                if (!tempoMap[userId]) {
                    tempoMap[userId] = { totalHours: 0, count: 0, name: nome };
                }
                tempoMap[userId].totalHours += diffHours;
                tempoMap[userId].count += 1;
            }
        });
        const tempoMedioPorUsuario = Object.keys(tempoMap).map((key) => ({
            name: tempoMap[key].name,
            averageHours: tempoMap[key].totalHours / tempoMap[key].count,
        }));

        setMetrics({
            totalChamados,
            resolvedChamados: resolvedChamados.length,
            slaPercent,
            categoryData,
            situacaoData,
            usuariosResolucao,
            tempoMedioPorUsuario,
        });
    };

    // Cores para o gráfico de pizza (você pode ajustar conforme desejar)
    const COLORS = ["#0088FE", "#00C49F", "#FFBB28", "#FF8042", "#AA336A", "#66CCFF"];

    return (
        <div className="p-4">
            <h1 className="text-3xl font-bold mb-6">Painel de Métricas dos Chamados</h1>
            {metrics ? (
                <>
                    <div className="mb-4">
                        <p>Total de Chamados: {metrics.totalChamados}</p>
                        <p>Chamados Resolvidos: {metrics.resolvedChamados}</p>
                        <p>
                            SLA (Resolvidos dentro do prazo no mês atual):{" "}
                            {metrics.slaPercent.toFixed(2)}%
                        </p>
                    </div>

                    <div className="flex flex-wrap gap-8">
                        {/* Gráfico de Pizza: Distribuição por Categorias */}
                        <div>
                            <h2 className="text-xl font-semibold mb-2">Categorias</h2>
                            <PieChart width={300} height={300}>
                                <Pie
                                    data={metrics.categoryData}
                                    dataKey="value"
                                    nameKey="name"
                                    cx="50%"
                                    cy="50%"
                                    outerRadius={100}
                                    fill="#8884d8"
                                    label
                                >
                                    {metrics.categoryData.map((entry, index) => (
                                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                                    ))}
                                </Pie>
                                <Tooltip />
                                <Legend />
                            </PieChart>
                        </div>

                        {/* Gráfico de Barras: Distribuição por Situações */}
                        <div>
                            <h2 className="text-xl font-semibold mb-2">Situações</h2>
                            <BarChart width={400} height={300} data={metrics.situacaoData}>
                                <CartesianGrid strokeDasharray="3 3" />
                                <XAxis dataKey="nome" />
                                <YAxis />
                                <Tooltip />
                                <Legend />
                                <Bar dataKey="count" fill="#82ca9d" />
                            </BarChart>
                        </div>

                        {/* Gráfico de Barras: Usuários que mais resolveram */}
                        <div>
                            <h2 className="text-xl font-semibold mb-2">Usuários que Resolveram</h2>
                            <BarChart width={400} height={300} data={metrics.usuariosResolucao}>
                                <CartesianGrid strokeDasharray="3 3" />
                                <XAxis dataKey="name" />
                                <YAxis />
                                <Tooltip />
                                <Legend />
                                <Bar dataKey="count" fill="#8884d8" />
                            </BarChart>
                        </div>
                    </div>

                    {/* Tabela: Tempo médio de resolução por usuário */}
                    <div className="mt-8">
                        <h2 className="text-xl font-semibold mb-2">Tempo Médio de Resolução (Horas)</h2>
                        <table className="min-w-full border">
                            <thead>
                                <tr>
                                    <th className="border p-2">Usuário</th>
                                    <th className="border p-2">Média (Horas)</th>
                                </tr>
                            </thead>
                            <tbody>
                                {metrics.tempoMedioPorUsuario.map((item, index) => (
                                    <tr key={index}>
                                        <td className="border p-2">{item.name}</td>
                                        <td className="border p-2">
                                            {item.averageHours.toFixed(2)}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </>
            ) : (
                <p>Carregando métricas...</p>
            )}
        </div>
    );
}
