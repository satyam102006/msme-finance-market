<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Helpers\AIHelper;
use App\Helpers\DataValidator;

class DashboardController extends Controller
{
    public function msmeDashboard()
    {
        $profile = DataValidator::validateMsmeProfile(json_decode(Storage::get('json/msme_profile.json'), true) ?? []);
        $offers = DataValidator::validateOffers(json_decode(Storage::get('json/offers.json'), true) ?? []);
        $rfps = DataValidator::validateRfps(json_decode(Storage::get('json/rfps.json'), true) ?? []);
        $bids = DataValidator::validateBids(json_decode(Storage::get('json/bids.json'), true) ?? []);

        // Filter offers for current MSME (MSME001)
        $msmeOffers = collect($offers)->where('msme_id', 'MSME001')->values();
        
        // Get AI recommendations
        $aiRecommendations = AIHelper::getDostAIRecommendation($msmeOffers->toArray());

        return view('msme.dashboard', compact('profile', 'msmeOffers', 'rfps', 'bids', 'aiRecommendations'));
    }

    public function lenderDashboard()
    {
        $msmes = DataValidator::validateMsmes(json_decode(Storage::get('json/msmes.json'), true) ?? []);
        $offers = DataValidator::validateOffers(json_decode(Storage::get('json/offers.json'), true) ?? []);

        return view('lender.dashboard', compact('msmes', 'offers'));
    }

    public function buyerDashboard()
    {
        $rfps = DataValidator::validateRfps(json_decode(Storage::get('json/rfps.json'), true) ?? []);
        $bids = DataValidator::validateBids(json_decode(Storage::get('json/bids.json'), true) ?? []);
        $msmeProfile = DataValidator::validateMsmeProfile(json_decode(Storage::get('json/msme_profile.json'), true) ?? []);

        // Group bids by RFP
        $bidsByRfp = collect($bids)->groupBy('rfp_id');

        return view('buyer.dashboard', compact('rfps', 'bidsByRfp', 'msmeProfile'));
    }

    public function getMsmeProfile($msmeId)
    {
        $profile = DataValidator::validateMsmeProfile(json_decode(Storage::get('json/msme_profile.json'), true) ?? []);
        
        return response()->json($profile);
    }
} 