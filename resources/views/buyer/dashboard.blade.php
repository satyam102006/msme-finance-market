@extends('layouts.app')

@section('title', 'Buyer Dashboard')

@section('content')
<div class="space-y-6">
    <!-- Header -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h1 class="text-2xl font-bold text-gray-900">Buyer Dashboard</h1>
        <p class="text-gray-600">Post RFPs and review bids from MSMEs</p>
    </div>

    <!-- Post RFP Form -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Post New RFP</h2>
        <form method="POST" action="{{ route('rfps.store') }}" class="space-y-4">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700">RFP Title</label>
                    <input type="text" name="title" required 
                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary"
                           placeholder="e.g., Electronic Components Supply">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Quantity</label>
                    <input type="number" name="quantity" required min="1"
                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary"
                           placeholder="5000">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Delivery Location</label>
                    <input type="text" name="delivery_location" required
                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary"
                           placeholder="Mumbai, Maharashtra">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Required Certification</label>
                    <input type="text" name="required_certification" required
                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary"
                           placeholder="ISO 9001">
                </div>
                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700">Deadline</label>
                    <input type="date" name="deadline" required
                           class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-primary focus:border-primary">
                </div>
            </div>
            <div>
                <button type="submit" class="bg-secondary text-white px-6 py-2 rounded-md hover:bg-green-700">
                    Post RFP
                </button>
            </div>
        </form>
    </div>

    <!-- Posted RFPs -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">Your Posted RFPs</h2>
        @if(count($rfps) > 0)
            <div class="space-y-4">
                @foreach($rfps as $rfp)
                <div class="border rounded-lg p-4">
                    <div class="flex justify-between items-start mb-3">
                        <div>
                            <h3 class="font-semibold text-lg">{{ $rfp['title'] }}</h3>
                            <p class="text-gray-600">RFP ID: {{ $rfp['id'] }}</p>
                        </div>
                        <div class="text-right">
                            <span class="text-sm text-gray-500">Posted: {{ $rfp['created_at'] }}</span>
                            <br>
                            <span class="text-sm text-red-600">Deadline: {{ $rfp['deadline'] }}</span>
                        </div>
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
                        <div>
                            <span class="text-sm font-medium text-gray-500">Buyer:</span>
                            <p class="text-sm">{{ $rfp['buyer'] }}</p>
                        </div>
                    </div>

                    <!-- Bids for this RFP -->
                    @if($bidsByRfp->has($rfp['id']))
                        <div class="border-t pt-4">
                            <h4 class="font-medium text-gray-900 mb-3">Bids Received ({{ $bidsByRfp->get($rfp['id'])->count() }})</h4>
                            <div class="space-y-3">
                                @foreach($bidsByRfp->get($rfp['id']) as $bid)
                                <div class="bg-gray-50 p-4 rounded-lg">
                                    <div class="flex justify-between items-start mb-2">
                                        <div>
                                            <h5 class="font-medium text-gray-900">{{ $bid['msme_id'] }}</h5>
                                            <p class="text-sm text-gray-600">Bid ID: {{ $bid['id'] }}</p>
                                        </div>
                                        <div class="text-right">
                                            <span class="px-2 py-1 text-xs font-semibold rounded-full 
                                                {{ $bid['fit_score'] >= 90 ? 'bg-green-100 text-green-800' : 
                                                   ($bid['fit_score'] >= 80 ? 'bg-blue-100 text-blue-800' : 'bg-yellow-100 text-yellow-800') }}">
                                                Fit Score: {{ $bid['fit_score'] }}%
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-3">
                                        <div>
                                            <span class="text-xs font-medium text-gray-500">Bid Price:</span>
                                            <p class="text-sm font-medium">₹{{ number_format($bid['price']) }}</p>
                                        </div>
                                        <div>
                                            <span class="text-xs font-medium text-gray-500">Delivery Time:</span>
                                            <p class="text-sm">{{ $bid['delivery_time'] }}</p>
                                        </div>
                                        <div>
                                            <span class="text-xs font-medium text-gray-500">Submitted:</span>
                                            <p class="text-sm">{{ $bid['created_at'] }}</p>
                                        </div>
                                        <div>
                                            <span class="text-xs font-medium text-gray-500">AI Fit Score:</span>
                                            <p class="text-sm font-medium">{{ $bid['fit_score'] }}% Match</p>
                                        </div>
                                    </div>
                                    
                                    <div>
                                        <span class="text-xs font-medium text-gray-500">Notes:</span>
                                        <p class="text-sm text-gray-700">{{ $bid['notes'] }}</p>
                                    </div>
                                </div>
                                @endforeach
                            </div>
                        </div>
                    @else
                        <div class="border-t pt-4">
                            <p class="text-gray-500">No bids received yet for this RFP.</p>
                        </div>
                    @endif
                </div>
                @endforeach
            </div>
        @else
            <p class="text-gray-500">No RFPs posted yet.</p>
        @endif
    </div>

    <!-- All Bids Summary -->
    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-semibold mb-4">All Bids Summary</h2>
        @if($bidsByRfp->count() > 0)
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">RFP</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">MSME</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Bid Price</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Delivery Time</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">AI Fit Score</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Submitted</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        @foreach($bidsByRfp as $rfpId => $bids)
                            @foreach($bids as $bid)
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $rfpId }}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $bid['msme_id'] }}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">₹{{ number_format($bid['price']) }}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $bid['delivery_time'] }}</td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 text-xs font-semibold rounded-full 
                                        {{ $bid['fit_score'] >= 90 ? 'bg-green-100 text-green-800' : 
                                           ($bid['fit_score'] >= 80 ? 'bg-blue-100 text-blue-800' : 'bg-yellow-100 text-yellow-800') }}">
                                        {{ $bid['fit_score'] }}%
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">{{ $bid['created_at'] }}</td>
                            </tr>
                            @endforeach
                        @endforeach
                    </tbody>
                </table>
            </div>
        @else
            <p class="text-gray-500">No bids received yet.</p>
        @endif
    </div>
</div>
@endsection 