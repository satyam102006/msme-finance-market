<?php

namespace App\Helpers;

class DataValidator
{
    /**
     * Validate and sanitize offers data
     */
    public static function validateOffers($offers)
    {
        if (!is_array($offers)) {
            return [];
        }

        $validatedOffers = [];
        foreach ($offers as $offer) {
            $validatedOffers[] = [
                'id' => $offer['id'] ?? 'UNKNOWN',
                'lender' => $offer['lender'] ?? 'Unknown Lender',
                'lender_name' => $offer['lender_name'] ?? ($offer['lender'] ?? 'Unknown Lender'),
                'msme_id' => $offer['msme_id'] ?? 'UNKNOWN',
                'amount' => $offer['amount'] ?? '₹0',
                'loan_amount' => is_numeric($offer['loan_amount'] ?? 0) ? (int)($offer['loan_amount']) : 0,
                'interest_rate' => is_numeric($offer['interest_rate'] ?? 0) ? (float)($offer['interest_rate']) : 0,
                'tenure' => is_numeric($offer['tenure'] ?? 0) ? (int)($offer['tenure']) : 0,
                'processing_fee' => is_numeric($offer['processing_fee'] ?? 0) ? (int)($offer['processing_fee']) : 0,
                'fit_score' => is_numeric($offer['fit_score'] ?? 0) ? (int)($offer['fit_score']) : 0,
                'type' => $offer['type'] ?? 'Term Loan',
                'purpose' => $offer['purpose'] ?? 'Working Capital',
                'status' => $offer['status'] ?? 'Active',
                'created_at' => $offer['created_at'] ?? date('Y-m-d'),
                'collateral_required' => $offer['collateral_required'] ?? false,
                'disbursement_time' => $offer['disbursement_time'] ?? '7-10 days'
            ];
        }

        return $validatedOffers;
    }

    /**
     * Validate and sanitize bids data
     */
    public static function validateBids($bids)
    {
        if (!is_array($bids)) {
            return [];
        }

        $validatedBids = [];
        foreach ($bids as $bid) {
            $validatedBids[] = [
                'id' => $bid['id'] ?? 'UNKNOWN',
                'rfp_id' => $bid['rfp_id'] ?? 'UNKNOWN',
                'msme_id' => $bid['msme_id'] ?? 'UNKNOWN',
                'msme_name' => $bid['msme_name'] ?? 'Unknown MSME',
                'proposal' => $bid['proposal'] ?? 'No proposal provided',
                'budget' => $bid['budget'] ?? '₹0',
                'price' => is_numeric($bid['price'] ?? 0) ? (int)($bid['price']) : 0,
                'timeline' => $bid['timeline'] ?? 'Not specified',
                'delivery_time' => $bid['delivery_time'] ?? 'Not specified',
                'status' => $bid['status'] ?? 'Submitted',
                'submitted_at' => $bid['submitted_at'] ?? date('Y-m-d'),
                'created_at' => $bid['created_at'] ?? ($bid['submitted_at'] ?? date('Y-m-d')),
                'score' => is_numeric($bid['score'] ?? ($bid['fit_score'] ?? 0)) ? (int)($bid['score'] ?? ($bid['fit_score'] ?? 0)) : 0,
                'fit_score' => is_numeric($bid['fit_score'] ?? ($bid['score'] ?? 0)) ? (int)($bid['fit_score'] ?? ($bid['score'] ?? 0)) : 0,
                'notes' => $bid['notes'] ?? ($bid['proposal'] ?? 'No notes provided'),
                'strengths' => isset($bid['strengths']) && is_array($bid['strengths']) ? $bid['strengths'] : ['Quality service']
            ];
        }

        return $validatedBids;
    }

    /**
     * Validate and sanitize MSME profile data
     */
    public static function validateMsmeProfile($profile)
    {
        if (!is_array($profile)) {
            return [];
        }

        return [
            'business_name' => $profile['business_name'] ?? 'Unknown Business',
            'location' => $profile['location'] ?? 'Not specified',
            'compliance_rating' => is_numeric($profile['compliance_rating'] ?? 0) ? (int)($profile['compliance_rating']) : 0,
            'pan_verified' => $profile['pan_verified'] ?? false,
            'gstin_verified' => $profile['gstin_verified'] ?? false,
            'udyam_verified' => $profile['udyam_verified'] ?? false,
            'gst_filing' => is_array($profile['gst_filing'] ?? []) ? $profile['gst_filing'] : [],
            'turnover_data' => is_array($profile['turnover_data'] ?? []) ? $profile['turnover_data'] : [],
            'cash_flow_data' => is_array($profile['cash_flow_data'] ?? []) ? $profile['cash_flow_data'] : []
        ];
    }

    /**
     * Validate and sanitize RFPs data
     */
    public static function validateRfps($rfps)
    {
        if (!is_array($rfps)) {
            return [];
        }

        $validatedRfps = [];
        foreach ($rfps as $rfp) {
            $validatedRfps[] = [
                'id' => $rfp['id'] ?? 'UNKNOWN',
                'title' => $rfp['title'] ?? 'Untitled RFP',
                'description' => $rfp['description'] ?? 'No description provided',
                'buyer' => $rfp['buyer'] ?? 'Unknown Buyer',
                'budget' => $rfp['budget'] ?? '₹0',
                'quantity' => $rfp['quantity'] ?? 'Not specified',
                'delivery_location' => $rfp['delivery_location'] ?? 'Not specified',
                'required_certification' => $rfp['required_certification'] ?? 'None',
                'deadline' => $rfp['deadline'] ?? date('Y-m-d', strtotime('+30 days')),
                'status' => $rfp['status'] ?? 'Active',
                'created_at' => $rfp['created_at'] ?? date('Y-m-d')
            ];
        }

        return $validatedRfps;
    }

    /**
     * Validate and sanitize MSMEs list data
     */
    public static function validateMsmes($msmes)
    {
        if (!is_array($msmes)) {
            return [];
        }

        $validatedMsmes = [];
        foreach ($msmes as $msme) {
            $validatedMsmes[] = [
                'id' => $msme['id'] ?? 'UNKNOWN',
                'name' => $msme['name'] ?? 'Unknown MSME',
                'sector' => $msme['sector'] ?? 'Not specified',
                'industry' => $msme['industry'] ?? ($msme['sector'] ?? 'Not specified'),
                'location' => $msme['location'] ?? 'Not specified',
                'turnover' => is_numeric($msme['turnover'] ?? 0) ? (int)($msme['turnover']) : 0,
                'compliance_rating' => is_numeric($msme['compliance_rating'] ?? 0) ? (int)($msme['compliance_rating']) : 0,
                'stability_score' => is_numeric($msme['stability_score'] ?? 0) ? (int)($msme['stability_score']) : 0,
                'status' => $msme['status'] ?? 'Active',
                'created_at' => $msme['created_at'] ?? date('Y-m-d')
            ];
        }

        return $validatedMsmes;
    }

    /**
     * Auto-fix JSON data files
     */
    public static function autoFixJsonFiles()
    {
        $files = [
            'offers.json' => 'validateOffers',
            'bids.json' => 'validateBids',
            'msme_profile.json' => 'validateMsmeProfile',
            'rfps.json' => 'validateRfps',
            'msmes.json' => 'validateMsmes'
        ];

        foreach ($files as $filename => $validatorMethod) {
            $filepath = storage_path('app/json/' . $filename);
            
            if (file_exists($filepath)) {
                $data = json_decode(file_get_contents($filepath), true);
                if ($data !== null) {
                    $validatedData = self::$validatorMethod($data);
                    file_put_contents($filepath, json_encode($validatedData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
                }
            }
        }
    }
} 