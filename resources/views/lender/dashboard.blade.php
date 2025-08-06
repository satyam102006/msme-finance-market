@extends('layouts.app')

@section('title', 'Lender Dashboard')

@section('content')
<div class="space-y-6">
    <!-- Header -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h1 class="text-2xl font-bold text-gray-900">Lender Dashboard</h1>
        <p class="text-gray-600">Browse MSMEs and submit loan offers</p>
    </div>

    <!-- Filters -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Filters</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
                <label class="block text-sm font-medium text-gray-700">Turnover Range</label>
                <select id="turnoverFilter" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                    <option value="">All</option>
                    <option value="0-2000000">₹0 - ₹20 Lakhs</option>
                    <option value="2000000-5000000">₹20 Lakhs - ₹50 Lakhs</option>
                    <option value="5000000+">₹50 Lakhs+</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Compliance Rating</label>
                <select id="ratingFilter" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                    <option value="">All</option>
                    <option value="A+">A+</option>
                    <option value="A">A</option>
                    <option value="B+">B+</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Industry</label>
                <select id="industryFilter" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                    <option value="">All</option>
                    <option value="Manufacturing">Manufacturing</option>
                    <option value="Services">Services</option>
                    <option value="Technology">Technology</option>
                </select>
            </div>
        </div>
    </div>

    <!-- MSME Cards -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Available MSMEs</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="msmeGrid">
            @foreach($msmes as $msme)
            <div class="border rounded-lg p-4 hover:shadow-lg transition-shadow msme-card" 
                 data-turnover="{{ $msme['turnover'] }}" 
                 data-rating="{{ $msme['compliance_rating'] }}" 
                 data-industry="{{ $msme['industry'] }}">
                <div class="flex justify-between items-start mb-3">
                    <h3 class="font-semibold text-lg">{{ $msme['id'] }}</h3>
                    <span class="px-2 py-1 text-xs font-semibold rounded-full 
                        {{ $msme['compliance_rating'] === 'A+' ? 'bg-green-100 text-green-800' : 
                           ($msme['compliance_rating'] === 'A' ? 'bg-blue-100 text-blue-800' : 'bg-yellow-100 text-yellow-800') }}">
                        {{ $msme['compliance_rating'] }}
                    </span>
                </div>
                
                <div class="space-y-2 mb-4">
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600">Turnover:</span>
                        <span class="text-sm font-medium">₹{{ number_format($msme['turnover']) }}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600">Stability Score:</span>
                        <span class="text-sm font-medium">{{ $msme['stability_score'] }}%</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600">Location:</span>
                        <span class="text-sm font-medium">{{ $msme['location'] }}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-sm text-gray-600">Industry:</span>
                        <span class="text-sm font-medium">{{ $msme['industry'] }}</span>
                    </div>
                </div>

                <div class="space-y-2">
                    <button onclick="requestFullProfile('{{ $msme['id'] }}')" 
                            class="w-full bg-blue-600 text-white px-3 py-2 rounded-md hover:bg-blue-700 text-sm">
                        Request Full Profile
                    </button>
                    
                    <!-- Loan Offer Form -->
                    <form method="POST" action="{{ route('offers.store') }}" class="space-y-2">
                        @csrf
                        <input type="hidden" name="msme_id" value="{{ $msme['id'] }}">
                        
                        <div>
                            <label class="block text-xs font-medium text-gray-700">Loan Amount (₹)</label>
                            <input type="number" name="loan_amount" required min="100000" 
                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary text-sm"
                                   placeholder="500000">
                        </div>
                        
                        <div class="grid grid-cols-2 gap-2">
                            <div>
                                <label class="block text-xs font-medium text-gray-700">Interest Rate (%)</label>
                                <input type="number" name="interest_rate" required min="8" max="25" step="0.1"
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary text-sm"
                                       placeholder="12.5">
                            </div>
                            <div>
                                <label class="block text-xs font-medium text-gray-700">Tenure (months)</label>
                                <input type="number" name="tenure" required min="12" max="84"
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary text-sm"
                                       placeholder="36">
                            </div>
                        </div>
                        
                        <div>
                            <label class="block text-xs font-medium text-gray-700">Processing Fee (₹)</label>
                            <input type="number" name="processing_fee" required min="0"
                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary text-sm"
                                   placeholder="5000">
                        </div>
                        
                        <button type="submit" class="w-full bg-secondary text-white px-3 py-2 rounded-md hover:bg-green-700 text-sm">
                            Submit Offer
                        </button>
                    </form>
                </div>
            </div>
            @endforeach
        </div>
    </div>

    <!-- Recent Offers -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Recent Loan Offers</h2>
        @if(count($offers) > 0)
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">MSME ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Lender</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rate</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tenure</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fee</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        @foreach($offers as $offer)
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $offer['msme_id'] }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $offer['lender'] }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">₹{{ number_format($offer['loan_amount']) }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $offer['interest_rate'] }}%</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $offer['tenure'] }} months</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">₹{{ number_format($offer['processing_fee']) }}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $offer['created_at'] }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @else
            <p class="text-gray-500">No loan offers submitted yet.</p>
        @endif
    </div>
</div>

<!-- Full Profile Modal -->
<div id="profileModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden z-50">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-screen overflow-y-auto">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-lg font-semibold">Full MSME Profile</h3>
                    <button onclick="closeProfileModal()" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div id="profileContent">
                    <!-- Profile content will be loaded here -->
                </div>
            </div>
        </div>
    </div>
</div>

@push('scripts')
<script>
// Filter functionality
document.getElementById('turnoverFilter').addEventListener('change', filterMSMEs);
document.getElementById('ratingFilter').addEventListener('change', filterMSMEs);
document.getElementById('industryFilter').addEventListener('change', filterMSMEs);

function filterMSMEs() {
    const turnoverFilter = document.getElementById('turnoverFilter').value;
    const ratingFilter = document.getElementById('ratingFilter').value;
    const industryFilter = document.getElementById('industryFilter').value;
    
    const cards = document.querySelectorAll('.msme-card');
    
    cards.forEach(card => {
        let show = true;
        
        // Turnover filter
        if (turnoverFilter) {
            const turnover = parseInt(card.dataset.turnover);
            if (turnoverFilter === '0-2000000' && (turnover < 0 || turnover > 2000000)) show = false;
            if (turnoverFilter === '2000000-5000000' && (turnover < 2000000 || turnover > 5000000)) show = false;
            if (turnoverFilter === '5000000+' && turnover < 5000000) show = false;
        }
        
        // Rating filter
        if (ratingFilter && card.dataset.rating !== ratingFilter) show = false;
        
        // Industry filter
        if (industryFilter && card.dataset.industry !== industryFilter) show = false;
        
        card.style.display = show ? 'block' : 'none';
    });
}

// Profile modal functionality
function requestFullProfile(msmeId) {
    fetch(`/msme-profile/${msmeId}`)
        .then(response => response.json())
        .then(data => {
            const content = document.getElementById('profileContent');
            content.innerHTML = `
                <div class="space-y-4">
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <h4 class="font-medium text-gray-900">Business Name</h4>
                            <p class="text-gray-600">${data.business_name}</p>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900">Location</h4>
                            <p class="text-gray-600">${data.location}</p>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900">Compliance Rating</h4>
                            <p class="text-gray-600">${data.compliance_rating}</p>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900">Verification Status</h4>
                            <p class="text-gray-600">
                                PAN: ${data.pan_verified ? '✅' : '❌'}<br>
                                GSTIN: ${data.gstin_verified ? '✅' : '❌'}<br>
                                Udyam: ${data.udyam_verified ? '✅' : '❌'}
                            </p>
                        </div>
                    </div>
                    
                    <div>
                        <h4 class="font-medium text-gray-900 mb-2">Recent GST Filing</h4>
                        <div class="bg-gray-50 p-3 rounded">
                            <p class="text-sm text-gray-600">
                                Period: ${data.gst_filing[0].period}<br>
                                Amount: ₹${data.gst_filing[0].amount.toLocaleString()}<br>
                                Status: ${data.gst_filing[0].status}
                            </p>
                        </div>
                    </div>
                </div>
            `;
            document.getElementById('profileModal').classList.remove('hidden');
        })
        .catch(error => {
            console.error('Error loading profile:', error);
            alert('Error loading profile data');
        });
}

function closeProfileModal() {
    document.getElementById('profileModal').classList.add('hidden');
}
</script>
@endpush
@endsection 