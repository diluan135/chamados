"use client";
import { useEffect, useState } from "react";
import Header from "@/components/Header";
import MeusChamados from "@/components/MeusChamados";
import ChamadosEncerrados from "@/components/ChamadosEncerrados";
import NovoChamado from "@/components/NovoChamado";
import Painel from "@/components/Painel";

export default function ChamadosPage() {
  const [activePage, setActivePage] = useState("meusChamados");
  const [user, setUser] = useState<{ roles: string[] } | null>(null);

  useEffect(() => {
    // Carrega os dados do usuário do localStorage
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
  }, []);

  const renderContent = () => {
    switch (activePage) {
      case "novoChamado":
        return <NovoChamado />;
      case "meusChamados":
        return <MeusChamados />;
      case "chamadosEncerrados":
        return <ChamadosEncerrados />;
      case "Painel":
        return <Painel />;
      default:
        return null;
    }
  };

  return (
    <div>
      <Header user={user} onNavClick={setActivePage} />
      <div className="p-4">{renderContent()}</div>
    </div>
  );
}
