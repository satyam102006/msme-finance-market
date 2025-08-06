<?php

namespace App\Helpers;

class AIHelper
{
    /**
     * Compare loan offers and provide AI insights
     */
    public static function compareOffers($offers)
    {
        if (count($offers) < 2) {
            return "Only one offer available. Consider waiting for more options.";
        }

        $bestRate = collect($offers)->min('interest_rate');
        $noFee = collect($offers)->where('processing_fee', '₹0')->first();
        
        $insights = [];
        
        foreach ($offers as $offer) {
            if ($offer['interest_rate'] == $bestRate) {
                $insights[] = "Offer from {$offer['lender_name']} has the lowest interest rate at {$offer['interest_rate']}%.";
            }
            
            if ($offer['processing_fee'] == '₹0') {
                $insights[] = "Offer from {$offer['lender_name']} has no processing fee.";
            }
        }

        // Calculate savings example
        $offerA = $offers[0];
        $offerB = $offers[1];
        
        // Extract amounts
        $amountA = (float) preg_replace('/[^0-9.]/', '', $offerA['amount']);
        $amountB = (float) preg_replace('/[^0-9.]/', '', $offerB['amount']);
        
        if (strpos($offerA['amount'], 'Lakhs') !== false) {
            $amountA *= 100000;
        } elseif (strpos($offerA['amount'], 'Crores') !== false) {
            $amountA *= 10000000;
        }
        
        if (strpos($offerB['amount'], 'Lakhs') !== false) {
            $amountB *= 100000;
        } elseif (strpos($offerB['amount'], 'Crores') !== false) {
            $amountB *= 10000000;
        }
        
        $tenureA = (int) preg_replace('/[^0-9]/', '', $offerA['tenure']);
        $tenureB = (int) preg_replace('/[^0-9]/', '', $offerB['tenure']);
        
        $emiA = self::calculateEMI($amountA, $offerA['interest_rate'], $tenureA);
        $emiB = self::calculateEMI($amountB, $offerB['interest_rate'], $tenureB);
        
        $processingFeeA = (int) preg_replace('/[^0-9]/', '', $offerA['processing_fee']);
        $processingFeeB = (int) preg_replace('/[^0-9]/', '', $offerB['processing_fee']);
        
        $totalA = ($emiA * $tenureA) + $processingFeeA;
        $totalB = ($emiB * $tenureB) + $processingFeeB;
        
        $savings = abs($totalA - $totalB);
        $betterOffer = $totalA < $totalB ? $offerA['lender_name'] : $offerB['lender_name'];
        
        $insights[] = "{$betterOffer} will save ₹" . number_format($savings) . " over {$offerA['tenure']}.";

        return implode(" ", $insights);
    }

    /**
     * Calculate EMI for loan
     */
    private static function calculateEMI($principal, $rate, $tenure)
    {
        $rate = $rate / 12 / 100; // Monthly rate
        $emi = $principal * $rate * pow(1 + $rate, $tenure) / (pow(1 + $rate, $tenure) - 1);
        return $emi;
    }

    /**
     * Generate fit score for MSME bid on RFP
     */
    public static function generateFitScore($msmeProfile, $rfp)
    {
        // Mock logic based on location, certification, and business type
        $score = 70; // Base score
        
        // Location match
        if (str_contains(strtolower($msmeProfile['location']), strtolower($rfp['delivery_location']))) {
            $score += 15;
        }
        
        // Certification match (mock)
        if (str_contains(strtolower($msmeProfile['compliance_rating']), 'a')) {
            $score += 10;
        }
        
        // Random variation
        $score += rand(-5, 10);
        
        return min(95, max(70, $score));
    }

    /**
     * Get Dost AI recommendation for offers
     */
    public static function getDostAIRecommendation($offers)
    {
        if (empty($offers)) {
            return "No offers available at the moment.";
        }

        $recommendations = [];
        
        foreach ($offers as $offer) {
            // Extract amount from string like "₹75 Lakhs"
            $amountStr = $offer['amount'];
            $amount = (float) preg_replace('/[^0-9.]/', '', $amountStr);
            
            // Convert to actual amount (assuming Lakhs)
            if (strpos($amountStr, 'Lakhs') !== false) {
                $amount = $amount * 100000;
            } elseif (strpos($amountStr, 'Crores') !== false) {
                $amount = $amount * 10000000;
            }
            
            // Extract tenure from string like "36 months"
            $tenure = (int) preg_replace('/[^0-9]/', '', $offer['tenure']);
            
            $emi = self::calculateEMI($amount, $offer['interest_rate'], $tenure);
            $totalCost = ($emi * $tenure) + (int) preg_replace('/[^0-9]/', '', $offer['processing_fee']);
            
            $recommendations[] = [
                'lender' => $offer['lender_name'],
                'amount' => $offer['amount'],
                'interest_rate' => $offer['interest_rate'],
                'tenure' => $offer['tenure'],
                'monthly_emi' => round($emi),
                'total_cost' => round($totalCost),
                'processing_fee' => $offer['processing_fee'],
                'fit_score' => $offer['fit_score'],
                'recommendation' => $offer['processing_fee'] == '₹0' ? "No processing fee - excellent option" : "Standard processing fee"
            ];
        }

        return $recommendations;
    }
} 