<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Helpers\DataValidator;

class AutoValidateData
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        // Only run on dashboard routes
        if (str_contains($request->path(), 'dashboard')) {
            try {
                // Auto-fix JSON files if they have issues
                DataValidator::autoFixJsonFiles();
            } catch (\Exception $e) {
                // Log error but don't break the request
                \Log::warning('AutoValidateData middleware error: ' . $e->getMessage());
            }
        }

        return $next($request);
    }
} 