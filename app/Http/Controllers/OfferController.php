<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class OfferController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'msme_id' => 'required',
            'loan_amount' => 'required|numeric|min:100000',
            'interest_rate' => 'required|numeric|min:8|max:25',
            'tenure' => 'required|numeric|min:12|max:84',
            'processing_fee' => 'required|numeric|min:0'
        ]);

        $offers = json_decode(Storage::get('json/offers.json'), true);
        
        $newOffer = [
            'id' => 'OFFER' . str_pad(count($offers) + 1, 3, '0', STR_PAD_LEFT),
            'lender' => session('user.email'),
            'msme_id' => $request->msme_id,
            'loan_amount' => $request->loan_amount,
            'interest_rate' => $request->interest_rate,
            'tenure' => $request->tenure,
            'processing_fee' => $request->processing_fee,
            'created_at' => date('Y-m-d')
        ];

        $offers[] = $newOffer;
        
        Storage::put('json/offers.json', json_encode($offers, JSON_PRETTY_PRINT));

        return back()->with('success', 'Loan offer submitted successfully!');
    }
} 