<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\OfferController;
use App\Http\Controllers\BuyerController;
use App\Http\Controllers\BidController;

// Authentication routes
Route::get('/', function () {
    return redirect('/login');
});

Route::get('/login', [AuthController::class, 'showLogin'])->name('login');
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');



// MSME Dashboard routes
Route::middleware(['auth', 'role:msme', 'validate-data'])->group(function () {
    Route::get('/dashboard/msme', [DashboardController::class, 'msmeDashboard'])->name('msme.dashboard');
    Route::post('/bids', [BidController::class, 'store'])->name('bids.store');
});

// Lender Dashboard routes
Route::middleware(['auth', 'role:lender', 'validate-data'])->group(function () {
    Route::get('/dashboard/lender', [DashboardController::class, 'lenderDashboard'])->name('lender.dashboard');
    Route::post('/offers', [OfferController::class, 'store'])->name('offers.store');
    Route::get('/msme-profile/{msmeId}', [DashboardController::class, 'getMsmeProfile'])->name('msme.profile');
});

// Buyer Dashboard routes
Route::middleware(['auth', 'role:buyer', 'validate-data'])->group(function () {
    Route::get('/dashboard/buyer', [DashboardController::class, 'buyerDashboard'])->name('buyer.dashboard');
    Route::post('/rfps', [BuyerController::class, 'storeRfp'])->name('rfps.store');
}); 