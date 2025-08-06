<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BuyerController extends Controller
{
    public function storeRfp(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'quantity' => 'required|numeric|min:1',
            'delivery_location' => 'required|string|max:255',
            'required_certification' => 'required|string|max:255',
            'deadline' => 'required|date|after:today'
        ]);

        $rfps = json_decode(Storage::get('json/rfps.json'), true);
        
        $newRfp = [
            'id' => 'RFP' . str_pad(count($rfps) + 1, 3, '0', STR_PAD_LEFT),
            'title' => $request->title,
            'quantity' => $request->quantity,
            'delivery_location' => $request->delivery_location,
            'required_certification' => $request->required_certification,
            'deadline' => $request->deadline,
            'buyer' => session('user.email'),
            'created_at' => date('Y-m-d')
        ];

        $rfps[] = $newRfp;
        
        Storage::put('json/rfps.json', json_encode($rfps, JSON_PRETTY_PRINT));

        return back()->with('success', 'RFP posted successfully!');
    }
} 