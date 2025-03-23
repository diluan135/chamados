<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class CorsMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        // Se for OPTIONS, retorna imediatamente com os headers
        if ($request->getMethod() === "OPTIONS") {
            $response = response('', 200);
            $this->setCorsHeaders($response);
            return $response;
        }

        $response = $next($request);
        $this->setCorsHeaders($response);
        return $response;
    }

    private function setCorsHeaders($response)
    {
        $response->headers->set('Access-Control-Allow-Origin', '*');
        $response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        $response->headers->set('Access-Control-Allow-Headers', 'Content-Type, Authorization');
        $response->headers->set('Access-Control-Allow-Credentials', 'true');
    }
}
