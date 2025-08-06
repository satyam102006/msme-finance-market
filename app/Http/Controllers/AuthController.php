<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class AuthController extends Controller
{
    public function showLogin()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        $users = json_decode(Storage::get('json/users.json'), true);
        
        $user = collect($users)->first(function ($user) use ($request) {
            return $user['email'] === $request->email && $user['password'] === $request->password;
        });

        if (!$user) {
            return back()->withErrors(['email' => 'Invalid credentials']);
        }

        session(['user' => $user]);

        return redirect("/dashboard/{$user['role']}");
    }

    public function logout()
    {
        session()->forget('user');
        return redirect('/login');
    }
} 