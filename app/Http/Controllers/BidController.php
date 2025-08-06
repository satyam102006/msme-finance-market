<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Helpers\AIHelper;

class BidController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'rfp_id' => 'required',
            'price' => 'required|numeric|min:1000',
            'delivery_time' => 'required|string|max:100',
            'notes' => 'required|string|max:500'
        ]);

        $bids = json_decode(Storage::get('json/bids.json'), true);
        $rfps = json_decode(Storage::get('json/rfps.json'), true);
        $msmeProfile = json_decode(Storage::get('json/msme_profile.json'), true);
        
        // Find the RFP
        $rfp = collect($rfps)->firstWhere('id', $request->rfp_id);
        
        // Generate fit score
        $fitScore = AIHelper::generateFitScore($msmeProfile, $rfp);
        
        $newBid = [
            'id' => 'BID' . str_pad(count($bids) + 1, 3, '0', STR_PAD_LEFT),
            'rfp_id' => $request->rfp_id,
            'msme_id' => 'MSME001', // Current MSME
            'price' => $request->price,
            'delivery_time' => $request->delivery_time,
            'notes' => $request->notes,
            'fit_score' => $fitScore,
            'created_at' => date('Y-m-d')
        ];

        $bids[] = $newBid;
        
        Storage::put('json/bids.json', json_encode($bids, JSON_PRETTY_PRINT));

        return back()->with('success', 'Bid submitted successfully! Fit Score: ' . $fitScore . '%');
    }
} 