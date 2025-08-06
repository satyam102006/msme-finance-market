@extends('layouts.app')

@section('title', 'MSME Dashboard')

@section('content')
<div class="space-y-6">
    <!-- Header -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h1 class="text-2xl font-bold text-gray-900">MSME Dashboard</h1>
        <p class="text-gray-600">Welcome to your business dashboard</p>
    </div>

    <!-- Business Profile -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Business Profile</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div class="bg-blue-50 p-4 rounded-lg">
                <h3 class="font-medium text-blue-900">Business Name</h3>
                <p class="text-blue-700">{{ $profile['business_name'] }}</p>
            </div>
            <div class="bg-green-50 p-4 rounded-lg">
                <h3 class="font-medium text-green-900">Location</h3>
                <p class="text-green-700">{{ $profile['location'] }}</p>
            </div>
            <div class="bg-purple-50 p-4 rounded-lg">
                <h3 class="font-medium text-purple-900">Compliance Rating</h3>
                <p class="text-purple-700">{{ $profile['compliance_rating'] }}</p>
            </div>
        </div>
    </div>

    <!-- Verification Checklist -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Verification Checklist</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div class="flex items-center space-x-3">
                <div class="w-6 h-6 rounded-full {{ $profile['pan_verified'] ? 'bg-green-500' : 'bg-red-500' }} flex items-center justify-center">
                    <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                <span class="font-medium">PAN Verified</span>
            </div>
            <div class="flex items-center space-x-3">
                <div class="w-6 h-6 rounded-full {{ $profile['gstin_verified'] ? 'bg-green-500' : 'bg-red-500' }} flex items-center justify-center">
                    <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                <span class="font-medium">GSTIN Verified</span>
            </div>
            <div class="flex items-center space-x-3">
                <div class="w-6 h-6 rounded-full {{ $profile['udyam_verified'] ? 'bg-green-500' : 'bg-red-500' }} flex items-center justify-center">
                    <svg class="w-4 h-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                <span class="font-medium">Udyam Verified</span>
            </div>
        </div>
    </div>

    <!-- Charts -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- Turnover vs Bank Credits Chart -->
        <div class="bg-white p-6 rounded-lg shadow">
            <h2 class="text-xl font-semibold mb-4">Turnover vs Bank Credits (12 Months)</h2>
            <canvas id="turnoverChart" width="400" height="200"></canvas>
        </div>

        <!-- Cash Flow Chart -->
        <div class="bg-white p-6 rounded-lg shadow">
            <h2 class="text-xl font-semibold mb-4">Cash Flow (6 Months)</h2>
            <canvas id="cashFlowChart" width="400" height="200"></canvas>
        </div>
    </div>

    <!-- GST Filing Table -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">GST Filing History</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Period</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Filing Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    @foreach($profile['gst_filing'] as $filing)
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $filing['period'] }}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $filing['filing_date'] }}</td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                {{ $filing['status'] }}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">₹{{ number_format($filing['amount']) }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>

    <!-- Loan Offers -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Loan Offers</h2>
        @if($msmeOffers->count() > 0)
            <div class="space-y-4">
                @foreach($msmeOffers as $offer)
                <div class="border rounded-lg p-4 hover:shadow-md transition-shadow">
                    <div class="flex justify-between items-start">
                        <div>
                            <h3 class="font-semibold text-lg">{{ $offer['lender'] }}</h3>
                            <p class="text-gray-600">Loan Amount: ₹{{ number_format($offer['loan_amount']) }}</p>
                            <p class="text-gray-600">Interest Rate: {{ $offer['interest_rate'] }}%</p>
                            <p class="text-gray-600">Tenure: {{ $offer['tenure'] }} months</p>
                            <p class="text-gray-600">Processing Fee: ₹{{ number_format($offer['processing_fee']) }}</p>
                        </div>
                        <div class="text-right">
                            <span class="text-sm text-gray-500">{{ $offer['created_at'] }}</span>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
        @else
            <p class="text-gray-500">No loan offers available at the moment.</p>
        @endif
    </div>

    <!-- Dost AI Recommendations -->
    @if(!empty($aiRecommendations))
    <div class="bg-blue-50 p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4 text-blue-900">🤖 Dost AI Recommendations</h2>
        <div class="space-y-3">
            @foreach($aiRecommendations as $rec)
            <div class="bg-white p-4 rounded-lg">
                <h3 class="font-semibold text-blue-800">{{ $rec['lender'] }}</h3>
                <p class="text-sm text-blue-700">Monthly EMI: ₹{{ number_format($rec['monthly_emi']) }}</p>
                <p class="text-sm text-blue-700">Total Cost: ₹{{ number_format($rec['total_cost']) }}</p>
                <p class="text-sm text-blue-700">{{ $rec['recommendation'] }}</p>
            </div>
            @endforeach
        </div>
    </div>
    @endif

    <!-- RFPs -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Available RFPs</h2>
        @if(count($rfps) > 0)
            <div class="space-y-4">
                @foreach($rfps as $rfp)
                <div class="border rounded-lg p-4">
                    <div class="flex justify-between items-start mb-3">
                        <div>
                            <h3 class="font-semibold text-lg">{{ $rfp['title'] }}</h3>
                            <p class="text-gray-600">{{ $rfp['buyer'] }}</p>
                        </div>
                        <span class="text-sm text-gray-500">Deadline: {{ $rfp['deadline'] }}</span>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
                        <div>
                            <span class="text-sm font-medium text-gray-500">Quantity:</span>
                            <p class="text-sm">{{ number_format($rfp['quantity']) }}</p>
                        </div>
                        <div>
                            <span class="text-sm font-medium text-gray-500">Location:</span>
                            <p class="text-sm">{{ $rfp['delivery_location'] }}</p>
                        </div>
                        <div>
                            <span class="text-sm font-medium text-gray-500">Certification:</span>
                            <p class="text-sm">{{ $rfp['required_certification'] }}</p>
                        </div>
                    </div>
                    
                    <!-- Bid Form -->
                    <form method="POST" action="{{ route('bids.store') }}" class="border-t pt-4">
                        @csrf
                        <input type="hidden" name="rfp_id" value="{{ $rfp['id'] }}">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Bid Price (₹)</label>
                                <input type="number" name="price" required min="1000" 
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Delivery Time</label>
                                <input type="text" name="delivery_time" required placeholder="e.g., 30 days"
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700">Notes</label>
                                <input type="text" name="notes" required placeholder="Additional details"
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                            </div>
                        </div>
                        <div class="mt-4">
                            <button type="submit" class="bg-secondary text-white px-4 py-2 rounded-md hover:bg-green-700">
                                Submit Bid
                            </button>
                        </div>
                    </form>
                </div>
                @endforeach
            </div>
        @else
            <p class="text-gray-500">No RFPs available at the moment.</p>
        @endif
    </div>
</div>

@push('scripts')
<script>
// Turnover vs Bank Credits Chart
const turnoverCtx = document.getElementById('turnoverChart').getContext('2d');
new Chart(turnoverCtx, {
    type: 'line',
    data: {
        labels: @json(collect($profile['turnover_data'])->pluck('month')),
        datasets: [{
            label: 'Turnover',
            data: @json(collect($profile['turnover_data'])->pluck('turnover')),
            borderColor: 'rgb(59, 130, 246)',
            backgroundColor: 'rgba(59, 130, 246, 0.1)',
            tension: 0.1
        }, {
            label: 'Bank Credits',
            data: @json(collect($profile['turnover_data'])->pluck('bank_credits')),
            borderColor: 'rgb(16, 185, 129)',
            backgroundColor: 'rgba(16, 185, 129, 0.1)',
            tension: 0.1
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return '₹' + (value / 1000) + 'K';
                    }
                }
            }
        }
    }
});

// Cash Flow Chart
const cashFlowCtx = document.getElementById('cashFlowChart').getContext('2d');
new Chart(cashFlowCtx, {
    type: 'bar',
    data: {
        labels: @json(collect($profile['cash_flow_data'])->pluck('month')),
        datasets: [{
            label: 'Cash In',
            data: @json(collect($profile['cash_flow_data'])->pluck('cash_in')),
            backgroundColor: 'rgba(16, 185, 129, 0.8)',
        }, {
            label: 'Cash Out',
            data: @json(collect($profile['cash_flow_data'])->pluck('cash_out')),
            backgroundColor: 'rgba(239, 68, 68, 0.8)',
        }, {
            label: 'Balance',
            data: @json(collect($profile['cash_flow_data'])->pluck('balance')),
            backgroundColor: 'rgba(59, 130, 246, 0.8)',
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return '₹' + (value / 1000) + 'K';
                    }
                }
            }
        }
    }
});
</script>
@endpush
@endsection 