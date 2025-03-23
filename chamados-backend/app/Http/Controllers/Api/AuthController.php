<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    // Método para login
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email'    => 'required|email',
            'password' => 'required'
        ]);

        if (!Auth::attempt($credentials)) {
            return response()->json(['message' => 'Credenciais inválidas'], 401);
        }

        // Recupera o usuário autenticado
        $user = Auth::user();

        // Cria um token para o usuário
        $token = $user->createToken('token-de-acesso')->plainTextToken;

        // Obtem as roles atribuídas ao usuário
        $roles = $user->getRoleNames(); // Retorna uma coleção com os nomes das roles

        return response()->json([
            'token' => $token,
            'user'  => $user,
            'roles' => $roles, // Aqui retornamos as roles
        ]);
    }


    // Método para logout (opcional)
    public function logout(Request $request)
    {
        // Revoga o token atual
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logout realizado com sucesso']);
    }

    public function register(Request $request)
    {
        // Validação dos dados recebidos
        $validator = Validator::make($request->all(), [
            'name'     => 'required|string|max:255',
            'email'    => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'roles'    => 'required|array|min:1',
        ]);

        // Verifica se a validação falhou
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Criação do novo usuário
        $user = User::create([
            'name'     => $request->name,
            'email'    => $request->email,
            'password' => Hash::make($request->password),
        ]);

        // Atribuir os papéis usando o método do Spatie
        foreach ($request->roles as $role) {
            $user->assignRole($role);
        }

        // Criação de um token para o usuário
        $token = $user->createToken('token-de-acesso')->plainTextToken;

        // Retorno dos dados do usuário e do token
        return response()->json([
            'user'  => $user,
            'token' => $token,
        ], 201);
    }
}
