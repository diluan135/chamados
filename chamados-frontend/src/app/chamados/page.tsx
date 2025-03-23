"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Header from "@/components/Header";
import MeusChamados from "@/components/MeusChamados";
import ChamadosEncerrados from "@/components/ChamadosEncerrados";
import NovoChamado from "@/components/NovoChamado";
import Painel from "@/components/Painel";

export default function ChamadosPage() {
  const [activePage, setActivePage] = useState("meusChamados");
  const [user, setUser] = useState<{ roles: string[] } | null>(null);
  const router = useRouter();

  useEffect(() => {
    if (typeof window !== "undefined") {
      const storedUser = localStorage.getItem("user");
      console.log(storedUser);
      if (storedUser) {
        setUser(JSON.parse(storedUser));
      } else {
        router.push("/login");
      }
    }
  }, [router]);

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

  if (!user) {
    return null; // Evita piscar a tela enquanto redireciona
  }

  return (
    <div>
      <Header user={user} onNavClick={setActivePage} />
      <div className="p-4">{renderContent()}</div>
    </div>
  );
}
