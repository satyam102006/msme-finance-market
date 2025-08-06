#!/bin/bash

# MSME Finance Market - Complete Automation Script
# This script automates the entire setup and configuration process

set -e  # Exit on any error

echo "🚀 MSME Finance Market - Complete Automation Setup"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if we're in the correct directory
if [ ! -f "composer.json" ]; then
    print_error "Please run this script from the MSME Finance Market project root directory"
    exit 1
fi

print_info "Starting automated setup process..."

# Step 1: Check PHP version
print_info "Checking PHP version..."
PHP_VERSION=$(php -r "echo PHP_VERSION;")
PHP_MAJOR=$(echo $PHP_VERSION | cut -d. -f1)
PHP_MINOR=$(echo $PHP_VERSION | cut -d. -f2)

if [ "$PHP_MAJOR" -lt 8 ] || ([ "$PHP_MAJOR" -eq 8 ] && [ "$PHP_MINOR" -lt 2 ]); then
    print_error "PHP 8.2 or higher is required. Current version: $PHP_VERSION"
    exit 1
fi
print_status "PHP version $PHP_VERSION is compatible"

# Step 2: Check Composer
print_info "Checking Composer..."
if ! command -v composer &> /dev/null; then
    print_error "Composer is not installed. Please install Composer first."
    exit 1
fi
print_status "Composer is available"

# Step 3: Install dependencies
print_info "Installing PHP dependencies..."
composer install --no-interaction
print_status "Dependencies installed successfully"

# Step 4: Create necessary directories
print_info "Creating required directories..."
mkdir -p storage/framework/sessions
mkdir -p storage/framework/views
mkdir -p storage/framework/cache
mkdir -p storage/logs
mkdir -p storage/app/json
mkdir -p bootstrap/cache
print_status "Directories created"

# Step 5: Set permissions
print_info "Setting proper permissions..."
chmod -R 755 storage/
chmod -R 755 bootstrap/cache/
print_status "Permissions set correctly"

# Step 6: Generate application key
print_info "Generating application key..."
if [ ! -f ".env" ]; then
    cp .env.example .env 2>/dev/null || echo "APP_NAME=\"MSME Finance Market\"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8000
SESSION_DRIVER=file
CACHE_DRIVER=file" > .env
fi
php artisan key:generate --force
print_status "Application key generated"

# Step 7: Create storage link
print_info "Creating storage link..."
php artisan storage:link
print_status "Storage link created"

# Step 8: Initialize JSON data files
print_info "Initializing JSON data files..."

# Create users.json if it doesn't exist
if [ ! -f "storage/app/json/users.json" ]; then
    echo '[
    {
        "email": "msme@example.com",
        "password": "password",
        "role": "msme"
    },
    {
        "email": "lender@example.com",
        "password": "password",
        "role": "lender"
    },
    {
        "email": "buyer@example.com",
        "password": "password",
        "role": "buyer"
    }
]' > storage/app/json/users.json
    print_status "users.json created"
fi

# Create msme_profile.json if it doesn't exist
if [ ! -f "storage/app/json/msme_profile.json" ]; then
    echo '{
    "business_name": "Tech Solutions Ltd",
    "location": "Bangalore",
    "compliance_rating": 85,
    "pan_verified": true,
    "gstin_verified": true,
    "udyam_verified": true,
    "gst_filing": {
        "period": "2024-25",
        "filing_date": "2024-04-15",
        "status": "Filed",
        "amount": 250000
    },
    "turnover_data": [
        {"month": "Jan", "turnover": 2500000, "credits": 1800000},
        {"month": "Feb", "turnover": 2800000, "credits": 2000000},
        {"month": "Mar", "turnover": 3200000, "credits": 2400000}
    ],
    "cash_flow_data": [
        {"month": "Jan", "cash_in": 2500000, "cash_out": 2000000, "balance": 500000},
        {"month": "Feb", "cash_in": 2800000, "cash_out": 2200000, "balance": 600000},
        {"month": "Mar", "cash_in": 3200000, "cash_out": 2600000, "balance": 600000}
    ]
}' > storage/app/json/msme_profile.json
    print_status "msme_profile.json created"
fi

# Create offers.json if it doesn't exist
if [ ! -f "storage/app/json/offers.json" ]; then
    echo '[
    {
        "id": "OFFER001",
        "lender": "HDFC Bank",
        "lender_name": "HDFC Bank",
        "msme_id": "MSME001",
        "amount": "₹25 Lakhs",
        "loan_amount": 2500000,
        "interest_rate": 12.5,
        "tenure": 36,
        "processing_fee": 15000,
        "fit_score": 88,
        "type": "Term Loan",
        "purpose": "Working Capital",
        "status": "Active",
        "created_at": "2024-01-20",
        "collateral_required": false,
        "disbursement_time": "7-10 days"
    }
]' > storage/app/json/offers.json
    print_status "offers.json created"
fi

# Create msmes.json if it doesn't exist
if [ ! -f "storage/app/json/msmes.json" ]; then
    echo '[
    {
        "id": "MSME001",
        "name": "Tech Solutions Ltd",
        "sector": "Technology",
        "industry": "Technology",
        "location": "Bangalore",
        "turnover": 25000000,
        "compliance_rating": 85,
        "stability_score": 90,
        "status": "Active",
        "created_at": "2024-01-15"
    }
]' > storage/app/json/msmes.json
    print_status "msmes.json created"
fi

# Create rfps.json if it doesn't exist
if [ ! -f "storage/app/json/rfps.json" ]; then
    echo '[
    {
        "id": "RFP001",
        "title": "Software Development Services",
        "description": "Custom software development for inventory management",
        "buyer": "buyer@example.com",
        "budget": "₹5 Lakhs",
        "quantity": "1 project",
        "delivery_location": "Bangalore",
        "required_certification": "ISO 9001",
        "deadline": "2024-02-15",
        "status": "Active",
        "created_at": "2024-01-10"
    }
]' > storage/app/json/rfps.json
    print_status "rfps.json created"
fi

# Create bids.json if it doesn't exist
if [ ! -f "storage/app/json/bids.json" ]; then
    echo '[
    {
        "id": "BID001",
        "rfp_id": "RFP001",
        "msme_id": "MSME001",
        "msme_name": "Tech Solutions Ltd",
        "proposal": "Comprehensive software development solution",
        "budget": "₹4.5 Lakhs",
        "price": 450000,
        "timeline": "3 months",
        "delivery_time": "3 months",
        "status": "Submitted",
        "submitted_at": "2024-01-12",
        "created_at": "2024-01-12",
        "score": 85,
        "fit_score": 85,
        "notes": "Experienced team with 5+ years in similar projects",
        "strengths": ["Quick delivery", "Competitive pricing", "Quality service"]
    }
]' > storage/app/json/bids.json
    print_status "bids.json created"
fi

# Step 9: Run data validation
print_info "Running initial data validation..."
php artisan data:fix-json --force
print_status "Data validation completed"

# Step 10: Test the application
print_info "Testing application setup..."
php artisan route:list --name=dashboard > /dev/null 2>&1
print_status "Routes are properly configured"

# Step 11: Create automation scripts
print_info "Creating additional automation scripts..."

# Create auto-start script
cat > start-app.sh << 'EOF'
#!/bin/bash
echo "🚀 Starting MSME Finance Market..."
echo "📊 Application will be available at: http://localhost:8000"
echo "👥 Demo Users:"
echo "   - MSME: msme@example.com / password"
echo "   - Lender: lender@example.com / password"
echo "   - Buyer: buyer@example.com / password"
echo ""
echo "Press Ctrl+C to stop the server"
php artisan serve
EOF
chmod +x start-app.sh

# Create data backup script
cat > backup-data.sh << 'EOF'
#!/bin/bash
BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp -r storage/app/json/* "$BACKUP_DIR/"
echo "✅ Data backed up to: $BACKUP_DIR"
EOF
chmod +x backup-data.sh

# Create data restore script
cat > restore-data.sh << 'EOF'
#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: ./restore-data.sh <backup_directory>"
    echo "Available backups:"
    ls -la backups/ 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_DIR="$1"
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Backup directory not found: $BACKUP_DIR"
    exit 1
fi

cp -r "$BACKUP_DIR"/* storage/app/json/
echo "✅ Data restored from: $BACKUP_DIR"
EOF
chmod +x restore-data.sh

# Create health check script
cat > health-check.sh << 'EOF'
#!/bin/bash
echo "🔍 MSME Finance Market Health Check"
echo "==================================="

# Check if Laravel is working
if php artisan --version > /dev/null 2>&1; then
    echo "✅ Laravel application is working"
else
    echo "❌ Laravel application has issues"
fi

# Check JSON files
echo ""
echo "📄 Checking JSON data files..."
for file in users.json msme_profile.json offers.json msmes.json rfps.json bids.json; do
    if [ -f "storage/app/json/$file" ]; then
        if php -r "json_decode(file_get_contents('storage/app/json/$file')); echo json_last_error() === JSON_ERROR_NONE ? 'valid' : 'invalid';" 2>/dev/null | grep -q "valid"; then
            echo "✅ $file is valid"
        else
            echo "❌ $file has JSON errors"
        fi
    else
        echo "❌ $file is missing"
    fi
done

# Check permissions
echo ""
echo "🔐 Checking permissions..."
if [ -w "storage/" ]; then
    echo "✅ Storage directory is writable"
else
    echo "❌ Storage directory is not writable"
fi

# Check routes
echo ""
echo "🛣️  Checking routes..."
if php artisan route:list --name=dashboard > /dev/null 2>&1; then
    echo "✅ Dashboard routes are configured"
else
    echo "❌ Dashboard routes have issues"
fi

echo ""
echo "🎉 Health check completed!"
EOF
chmod +x health-check.sh

print_status "Automation scripts created"

# Step 12: Final status
echo ""
echo "🎉 MSME Finance Market Setup Complete!"
echo "======================================"
echo ""
echo "📁 Project Structure:"
echo "   ├── app/Http/Controllers/     # Application logic"
echo "   ├── app/Helpers/              # AI and data helpers"
echo "   ├── resources/views/          # Blade templates"
echo "   ├── storage/app/json/         # JSON data files"
echo "   └── routes/web.php           # Application routes"
echo ""
echo "🚀 Quick Start Commands:"
echo "   ./start-app.sh               # Start the application"
echo "   ./health-check.sh            # Check system health"
echo "   ./backup-data.sh             # Backup JSON data"
echo "   ./restore-data.sh <backup>   # Restore from backup"
echo "   php artisan data:fix-json    # Fix data issues"
echo ""
echo "🌐 Access the Application:"
echo "   URL: http://localhost:8000"
echo "   Login: Use any demo credentials below"
echo ""
echo "👥 Demo Users:"
echo "   MSME:   msme@example.com / password"
echo "   Lender: lender@example.com / password"
echo "   Buyer:  buyer@example.com / password"
echo ""
echo "🔧 Management Commands:"
echo "   php artisan serve             # Start development server"
echo "   php artisan data:fix-json    # Validate and fix JSON data"
echo "   php artisan route:list       # List all routes"
echo ""
echo "✅ Setup completed successfully!"
echo "🚀 Run './start-app.sh' to start the application" 