"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import axios from "axios";

export default function RegisterPage() {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [passwordConfirmation, setPasswordConfirmation] = useState("");
  const [roles, setRoles] = useState<string[]>([]);
  const [errors, setErrors] = useState<any>(null);
  const router = useRouter();

  const handleRoleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value, checked } = e.target;
    if (checked) {
      // Adiciona o role se não estiver presente
      setRoles((prev) => [...prev, value]);
    } else {
      // Remove o role
      setRoles((prev) => prev.filter((role) => role !== value));
    }
  };

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrors(null);

    try {
      const response = await axios.post(
        "http://localhost:8000/api/register",
        {
          name,
          email,
          password,
          password_confirmation: passwordConfirmation,
          roles, // enviando os papéis selecionados
        }
      );

      // Opcional: você pode armazenar dados retornados se necessário
      // Em seguida, redireciona para a página de login
      router.push("/login");
    } catch (error: any) {
      if (error.response && error.response.data.errors) {
        setErrors(error.response.data.errors);
      } else {
        console.error(error);
      }
    }
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center text-gray-900 bg-gray-100">
      <h1 className="text-2xl font-bold mb-4">Cadastro</h1>
      <form onSubmit={handleRegister} className="w-full max-w-sm">
        {/* Nome */}
        <div className="mb-4">
          <label className="block mb-1" htmlFor="name">
            Nome
          </label>
          <input
            id="name"
            type="text"
            className="border p-2 w-full"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
          {errors?.name && (
            <p className="text-red-500 text-sm">{errors.name[0]}</p>
          )}
        </div>
        {/* Email */}
        <div className="mb-4">
          <label className="block mb-1" htmlFor="email">
            Email
          </label>
          <input
            id="email"
            type="email"
            className="border p-2 w-full"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          {errors?.email && (
            <p className="text-red-500 text-sm">{errors.email[0]}</p>
          )}
        </div>
        {/* Senha */}
        <div className="mb-4">
          <label className="block mb-1" htmlFor="password">
            Senha
          </label>
          <input
            id="password"
            type="password"
            className="border p-2 w-full"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          {errors?.password && (
            <p className="text-red-500 text-sm">{errors.password[0]}</p>
          )}
        </div>
        {/* Confirmação de Senha */}
        <div className="mb-4">
          <label className="block mb-1" htmlFor="passwordConfirmation">
            Confirme a Senha
          </label>
          <input
            id="passwordConfirmation"
            type="password"
            className="border p-2 w-full"
            value={passwordConfirmation}
            onChange={(e) => setPasswordConfirmation(e.target.value)}
            required
          />
        </div>
        {/* Seleção de Roles */}
        <div className="mb-4">
          <span className="block mb-1">Selecione seu(s) papel(is):</span>
          <div className="flex items-center mb-2">
            <input
              type="checkbox"
              id="role_usuario"
              value="usuario"
              onChange={handleRoleChange}
            />
            <label htmlFor="role_usuario" className="ml-2">
              Usuário
            </label>
          </div>
          <div className="flex items-center">
            <input
              type="checkbox"
              id="role_administrador"
              value="administrador"
              onChange={handleRoleChange}
            />
            <label htmlFor="role_administrador" className="ml-2">
              Administrador
            </label>
          </div>
          {errors?.roles && (
            <p className="text-red-500 text-sm">{errors.roles[0]}</p>
          )}
        </div>
        <button
          type="submit"
          className="bg-blue-500 text-white p-2 rounded w-full hover:bg-blue-600 cursor-pointer"
        >
          Cadastrar
        </button>
      </form>
    </div>
  );
}
