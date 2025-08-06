#!/bin/bash

# MSME Finance Market - Data Automation Script
# This script automates all data management tasks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

print_status() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_header() { echo -e "${PURPLE}🔧 $1${NC}"; }

# Function to show usage
show_usage() {
    echo "MSME Finance Market - Data Automation"
    echo "====================================="
    echo ""
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  validate     - Validate and fix all JSON data files"
    echo "  backup       - Create backup of all JSON data"
    echo "  restore      - Restore data from backup"
    echo "  monitor      - Monitor data files for changes"
    echo "  generate     - Generate sample data"
    echo "  clean        - Clean old backups"
    echo "  status       - Show current data status"
    echo "  health       - Comprehensive health check"
    echo ""
    echo "Options:"
    echo "  --force      - Force operations without confirmation"
    echo "  --verbose    - Show detailed output"
    echo "  --backup-dir - Specify backup directory"
    echo ""
    echo "Examples:"
    echo "  $0 validate --force"
    echo "  $0 backup --backup-dir ./my-backups"
    echo "  $0 restore backups/20241201_143022"
    echo "  $0 monitor --verbose"
}

# Function to validate JSON data
validate_data() {
    print_header "Validating JSON Data Files"
    
    if [ "$1" = "--force" ]; then
        print_info "Running forced validation..."
        php artisan data:fix-json --force
    else
        print_info "Running standard validation..."
        php artisan data:fix-json
    fi
    
    print_status "Data validation completed"
}

# Function to backup data
backup_data() {
    print_header "Creating Data Backup"
    
    BACKUP_DIR=${2:-"backups/$(date +%Y%m%d_%H%M%S)"}
    mkdir -p "$BACKUP_DIR"
    
    print_info "Backing up to: $BACKUP_DIR"
    
    # Backup all JSON files
    cp -r storage/app/json/* "$BACKUP_DIR/"
    
    # Create backup metadata
    cat > "$BACKUP_DIR/backup-info.txt" << EOF
Backup created: $(date)
Files backed up:
$(ls -la "$BACKUP_DIR"/*.json 2>/dev/null | wc -l) JSON files
Total size: $(du -sh "$BACKUP_DIR" | cut -f1)
EOF
    
    print_status "Backup completed: $BACKUP_DIR"
    print_info "Backup size: $(du -sh "$BACKUP_DIR" | cut -f1)"
}

# Function to restore data
restore_data() {
    if [ -z "$1" ]; then
        print_error "Please specify backup directory"
        echo "Available backups:"
        ls -la backups/ 2>/dev/null || echo "No backups found"
        exit 1
    fi
    
    BACKUP_DIR="$1"
    if [ ! -d "$BACKUP_DIR" ]; then
        print_error "Backup directory not found: $BACKUP_DIR"
        exit 1
    fi
    
    print_header "Restoring Data from Backup"
    print_info "Restoring from: $BACKUP_DIR"
    
    # Confirm restoration
    if [ "$2" != "--force" ]; then
        read -p "Are you sure you want to restore data from $BACKUP_DIR? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_warning "Restoration cancelled"
            exit 0
        fi
    fi
    
    # Restore files
    cp -r "$BACKUP_DIR"/*.json storage/app/json/
    
    print_status "Data restored successfully"
    print_info "Restored files:"
    ls -la storage/app/json/*.json
}

# Function to monitor data files
monitor_data() {
    print_header "Monitoring Data Files"
    
    print_info "Monitoring JSON files for changes..."
    print_info "Press Ctrl+C to stop monitoring"
    
    # Get initial file states
    declare -A file_hashes
    for file in storage/app/json/*.json; do
        if [ -f "$file" ]; then
            file_hashes["$file"]=$(md5sum "$file" | cut -d' ' -f1)
        fi
    done
    
    # Monitor for changes
    while true; do
        for file in storage/app/json/*.json; do
            if [ -f "$file" ]; then
                current_hash=$(md5sum "$file" | cut -d' ' -f1)
                if [ "${file_hashes[$file]}" != "$current_hash" ]; then
                    print_warning "File changed: $(basename "$file")"
                    file_hashes["$file"]=$current_hash
                    
                    if [ "$1" = "--verbose" ]; then
                        echo "  Size: $(du -h "$file" | cut -f1)"
                        echo "  Modified: $(stat -c %y "$file")"
                    fi
                fi
            fi
        done
        sleep 5
    done
}

# Function to generate sample data
generate_data() {
    print_header "Generating Sample Data"
    
    # Generate additional offers
    print_info "Generating additional loan offers..."
    php -r "
    \$offers = json_decode(file_get_contents('storage/app/json/offers.json'), true);
    \$newOffers = [
        [
            'id' => 'OFFER009',
            'lender' => 'SBI Bank',
            'lender_name' => 'SBI Bank',
            'msme_id' => 'MSME001',
            'amount' => '₹15 Lakhs',
            'loan_amount' => 1500000,
            'interest_rate' => 10.5,
            'tenure' => 48,
            'processing_fee' => 12000,
            'fit_score' => 87,
            'type' => 'Working Capital Loan',
            'purpose' => 'Inventory Purchase',
            'status' => 'Active',
            'created_at' => date('Y-m-d'),
            'collateral_required' => false,
            'disbursement_time' => '5-7 days'
        ],
        [
            'id' => 'OFFER010',
            'lender' => 'Axis Bank',
            'lender_name' => 'Axis Bank',
            'msme_id' => 'MSME001',
            'amount' => '₹30 Lakhs',
            'loan_amount' => 3000000,
            'interest_rate' => 11.2,
            'tenure' => 60,
            'processing_fee' => 18000,
            'fit_score' => 92,
            'type' => 'Term Loan',
            'purpose' => 'Equipment Purchase',
            'status' => 'Active',
            'created_at' => date('Y-m-d'),
            'collateral_required' => true,
            'disbursement_time' => '10-15 days'
        ]
    ];
    \$offers = array_merge(\$offers, \$newOffers);
    file_put_contents('storage/app/json/offers.json', json_encode(\$offers, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
    echo '✅ Generated 2 additional offers' . PHP_EOL;
    "
    
    # Generate additional RFPs
    print_info "Generating additional RFPs..."
    php -r "
    \$rfps = json_decode(file_get_contents('storage/app/json/rfps.json'), true);
    \$newRfps = [
        [
            'id' => 'RFP002',
            'title' => 'Digital Marketing Services',
            'description' => 'Comprehensive digital marketing campaign for B2B services',
            'buyer' => 'buyer@example.com',
            'budget' => '₹3 Lakhs',
            'quantity' => '6 months campaign',
            'delivery_location' => 'Mumbai',
            'required_certification' => 'Google Partner',
            'deadline' => date('Y-m-d', strtotime('+30 days')),
            'status' => 'Active',
            'created_at' => date('Y-m-d')
        ],
        [
            'id' => 'RFP003',
            'title' => 'Mobile App Development',
            'description' => 'Cross-platform mobile application for e-commerce',
            'buyer' => 'buyer@example.com',
            'budget' => '₹8 Lakhs',
            'quantity' => '1 application',
            'delivery_location' => 'Delhi',
            'required_certification' => 'ISO 27001',
            'deadline' => date('Y-m-d', strtotime('+45 days')),
            'status' => 'Active',
            'created_at' => date('Y-m-d')
        ]
    ];
    \$rfps = array_merge(\$rfps, \$newRfps);
    file_put_contents('storage/app/json/rfps.json', json_encode(\$rfps, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
    echo '✅ Generated 2 additional RFPs' . PHP_EOL;
    "
    
    # Generate additional bids
    print_info "Generating additional bids..."
    php -r "
    \$bids = json_decode(file_get_contents('storage/app/json/bids.json'), true);
    \$newBids = [
        [
            'id' => 'BID002',
            'rfp_id' => 'RFP002',
            'msme_id' => 'MSME001',
            'msme_name' => 'Tech Solutions Ltd',
            'proposal' => 'Comprehensive digital marketing strategy with ROI tracking',
            'budget' => '₹2.8 Lakhs',
            'price' => 280000,
            'timeline' => '6 months',
            'delivery_time' => '6 months',
            'status' => 'Submitted',
            'submitted_at' => date('Y-m-d'),
            'created_at' => date('Y-m-d'),
            'score' => 88,
            'fit_score' => 88,
            'notes' => 'Specialized in B2B digital marketing with proven track record',
            'strengths' => ['Data-driven approach', 'ROI tracking', 'B2B expertise']
        ],
        [
            'id' => 'BID003',
            'rfp_id' => 'RFP003',
            'msme_id' => 'MSME001',
            'msme_name' => 'Tech Solutions Ltd',
            'proposal' => 'Modern cross-platform mobile app with advanced features',
            'budget' => '₹7.5 Lakhs',
            'price' => 750000,
            'timeline' => '4 months',
            'delivery_time' => '4 months',
            'status' => 'Submitted',
            'submitted_at' => date('Y-m-d'),
            'created_at' => date('Y-m-d'),
            'score' => 91,
            'fit_score' => 91,
            'notes' => 'Expert in React Native and Flutter development',
            'strengths' => ['Cross-platform expertise', 'UI/UX design', 'Security compliance']
        ]
    ];
    \$bids = array_merge(\$bids, \$newBids);
    file_put_contents('storage/app/json/bids.json', json_encode(\$bids, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
    echo '✅ Generated 2 additional bids' . PHP_EOL;
    "
    
    # Run validation
    print_info "Validating generated data..."
    php artisan data:fix-json
    
    print_status "Sample data generation completed"
}

# Function to clean old backups
clean_backups() {
    print_header "Cleaning Old Backups"
    
    if [ -d "backups" ]; then
        print_info "Found $(ls backups/ | wc -l) backup directories"
        
        # Keep only last 5 backups
        BACKUP_COUNT=$(ls backups/ | wc -l)
        if [ "$BACKUP_COUNT" -gt 5 ]; then
            print_info "Removing old backups (keeping last 5)..."
            ls -t backups/ | tail -n +6 | xargs -I {} rm -rf "backups/{}"
            print_status "Old backups cleaned"
        else
            print_info "No old backups to clean"
        fi
    else
        print_warning "No backups directory found"
    fi
}

# Function to show data status
show_status() {
    print_header "Data Status Report"
    
    echo "📊 JSON Data Files:"
    for file in storage/app/json/*.json; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            size=$(du -h "$file" | cut -f1)
            records=$(php -r "echo count(json_decode(file_get_contents('$file'), true) ?? []);")
            echo "  ✅ $filename ($size, $records records)"
        fi
    done
    
    echo ""
    echo "📈 Data Summary:"
    php -r "
    \$offers = count(json_decode(file_get_contents('storage/app/json/offers.json'), true) ?? []);
    \$rfps = count(json_decode(file_get_contents('storage/app/json/rfps.json'), true) ?? []);
    \$bids = count(json_decode(file_get_contents('storage/app/json/bids.json'), true) ?? []);
    \$msmes = count(json_decode(file_get_contents('storage/app/json/msmes.json'), true) ?? []);
    echo \"  • Loan Offers: \$offers\" . PHP_EOL;
    echo \"  • RFPs: \$rfps\" . PHP_EOL;
    echo \"  • Bids: \$bids\" . PHP_EOL;
    echo \"  • MSMEs: \$msmes\" . PHP_EOL;
    "
    
    echo ""
    echo "💾 Backups:"
    if [ -d "backups" ]; then
        BACKUP_COUNT=$(ls backups/ | wc -l)
        echo "  📁 $BACKUP_COUNT backup directories"
        echo "  📅 Latest: $(ls -t backups/ | head -1)"
    else
        echo "  ❌ No backups found"
    fi
}

# Function to run health check
run_health_check() {
    print_header "Comprehensive Health Check"
    
    # Check Laravel
    if php artisan --version > /dev/null 2>&1; then
        print_status "Laravel application is working"
    else
        print_error "Laravel application has issues"
    fi
    
    # Check JSON files
    echo ""
    print_info "Checking JSON data files..."
    for file in users.json msme_profile.json offers.json msmes.json rfps.json bids.json; do
        if [ -f "storage/app/json/$file" ]; then
            if php -r "json_decode(file_get_contents('storage/app/json/$file')); echo json_last_error() === JSON_ERROR_NONE ? 'valid' : 'invalid';" 2>/dev/null | grep -q "valid"; then
                print_status "$file is valid"
            else
                print_error "$file has JSON errors"
            fi
        else
            print_error "$file is missing"
        fi
    done
    
    # Check permissions
    echo ""
    print_info "Checking permissions..."
    if [ -w "storage/" ]; then
        print_status "Storage directory is writable"
    else
        print_error "Storage directory is not writable"
    fi
    
    # Check routes
    echo ""
    print_info "Checking routes..."
    if php artisan route:list --name=dashboard > /dev/null 2>&1; then
        print_status "Dashboard routes are configured"
    else
        print_error "Dashboard routes have issues"
    fi
    
    # Check data validation
    echo ""
    print_info "Running data validation test..."
    php artisan data:fix-json > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_status "Data validation is working"
    else
        print_error "Data validation has issues"
    fi
    
    echo ""
    print_status "Health check completed!"
}

# Main script logic
case "${1:-}" in
    "validate")
        validate_data "$2"
        ;;
    "backup")
        backup_data "$2" "$3"
        ;;
    "restore")
        restore_data "$2" "$3"
        ;;
    "monitor")
        monitor_data "$2"
        ;;
    "generate")
        generate_data
        ;;
    "clean")
        clean_backups
        ;;
    "status")
        show_status
        ;;
    "health")
        run_health_check
        ;;
    "help"|"-h"|"--help"|"")
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        show_usage
        exit 1
        ;;
esac 