"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import axios from "axios";

export default function LoginPage() {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const router = useRouter();

    async function handleLogin() {
        try {
            // Obter o cookie CSRF
            await axios.get("http://localhost:8000/sanctum/csrf-cookie", {
                withCredentials: true,
            });

            // Fazer a requisição de login
            const response = await axios.post(
                "http://localhost:8000/api/login",
                { email, password },
                { withCredentials: true }
            );

            console.log("Login bem-sucedido:", response.data);

            // Extrair os dados retornados
            const { token, user, roles } = response.data;

            // Armazenar os dados no localStorage
            user.roles = roles; // Mescla as roles no objeto user

            localStorage.setItem("token", token);
            localStorage.setItem("user", JSON.stringify(user));


            // Redirecionar para a página de chamados
            router.push("/chamados");
        } catch (error: any) {
            console.error("Erro no login:", error.response?.data || error.message);
        }
    }

    return (
        <div className="min-h-screen flex flex-col items-center justify-center">
            <h1 className="text-2xl font-bold mb-4">Login</h1>
            <input
                type="email"
                placeholder="Email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="border p-2 mb-4"
            />
            <input
                type="password"
                placeholder="Senha"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="border p-2 mb-4"
            />
            <button onClick={handleLogin} className="bg-blue-500 text-white p-2 rounded">
                Entrar
            </button>
        </div>
    );
}
