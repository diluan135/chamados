"use client";
import React from "react";
import { useRouter } from "next/navigation";

interface HeaderProps {
  user: { roles: string[] } | null;
  onNavClick: (page: string) => void;
}

export default function Header({ user, onNavClick }: HeaderProps) {
  const router = useRouter();

  const handleLogout = async () => {
    try {
      await fetch("http://localhost:8000/api/logout", {
        method: "POST",
        credentials: "include",
      });
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      localStorage.removeItem("roles");
      router.push("/login");
    } catch (error) {
      console.error("Erro no logout:", error);
    }
  };

  return (
    <header className="flex items-center justify-between p-4 bg-red-600">
      <div className="flex items-center space-x-4">
        {/* Se usuário tiver role "usuario", mostra o botão "Novo chamado" */}
        {user && user.roles.includes("administrador") && (
          <button onClick={() => onNavClick("Painel")}>
            Painel
          </button>
        )}
        {user && user.roles.includes("usuario") && !user.roles.includes("administrador") && (
          <button onClick={() => onNavClick("novoChamado")}>
            Novo chamado
          </button>
        )}
        <button onClick={() => onNavClick("meusChamados")}>
          {user && user.roles.includes("administrador") ? "Todos Chamados" : "Meus Chamados"}
        </button>
        {/* Se usuário tiver role "administrador", mostra "Chamados Encerrados" */}
        {user && user.roles.includes("administrador") && (
          <button onClick={() => onNavClick("chamadosEncerrados")}>
            Chamados Encerrados
          </button>
        )}
      </div>
      <button onClick={handleLogout} className="text-gray-100">
        Logout
      </button>
    </header>
  );
}
