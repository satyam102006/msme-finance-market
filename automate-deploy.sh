#!/bin/bash

# MSME Finance Market - Deployment Automation Script
# Author: Satyam Yadav (@satyam102006)
# GitHub: https://github.com/satyam102006

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="msme-finance-market"
GITHUB_USERNAME="satyam102006"
GITHUB_REPO="msme-finance-market"
DEPLOYMENT_TYPE=""

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  MSME Finance Market Deployer${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install Git first."
        exit 1
    fi
    
    # Check if PHP is installed
    if ! command -v php &> /dev/null; then
        print_error "PHP is not installed. Please install PHP first."
        exit 1
    fi
    
    # Check if Composer is installed
    if ! command -v composer &> /dev/null; then
        print_error "Composer is not installed. Please install Composer first."
        exit 1
    fi
    
    print_success "All prerequisites are met!"
}

# Function to initialize Git repository
init_git_repo() {
    print_status "Initializing Git repository..."
    
    if [ ! -d ".git" ]; then
        git init
        print_success "Git repository initialized"
    else
        print_status "Git repository already exists"
    fi
}

# Function to create .gitignore
create_gitignore() {
    print_status "Creating .gitignore file..."
    
    cat > .gitignore << 'EOF'
# Laravel specific
/node_modules
/public/hot
/public/storage
/storage/*.key
/vendor
.env
.env.backup
.phpunit.result.cache
docker-compose.override.yml
Homestead.json
Homestead.yaml
npm-debug.log
yarn-error.log

# IDE files
.idea/
.vscode/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp

# Backup files
*.bak
*.backup

# Cache
cache/
*.cache

# Build files
build/
dist/

# Environment files
.env.local
.env.production
.env.staging

# Composer
composer.phar

# PHP
*.php~

# Laravel specific
bootstrap/cache/*.php
storage/framework/cache/*
storage/framework/sessions/*
storage/framework/views/*
storage/logs/*
!storage/framework/cache/.gitkeep
!storage/framework/sessions/.gitkeep
!storage/framework/views/.gitkeep
!storage/logs/.gitkeep

# Keep JSON data files
!storage/app/json/*.json
EOF

    print_success ".gitignore file created"
}

# Function to create deployment documentation
create_deployment_docs() {
    print_status "Creating deployment documentation..."
    
    cat > DEPLOYMENT.md << 'EOF'
# MSME Finance Market - Deployment Guide

## Overview
This document provides comprehensive deployment instructions for the MSME Finance Market application.

## Prerequisites
- PHP 8.1 or higher
- Composer
- Git
- Web server (Apache/Nginx) or hosting platform

## Deployment Options

### 1. Local Development
```bash
./automate-setup.sh
./start-app.sh
```

### 2. GitHub Pages (Static Demo)
```bash
./automate-deploy.sh github-pages
```

### 3. Heroku Deployment
```bash
./automate-deploy.sh heroku
```

### 4. Vercel Deployment
```bash
./automate-deploy.sh vercel
```

### 5. Railway Deployment
```bash
./automate-deploy.sh railway
```

### 6. DigitalOcean App Platform
```bash
./automate-deploy.sh digitalocean
```

## Environment Configuration

### Required Environment Variables
```env
APP_NAME="MSME Finance Market"
APP_ENV=production
APP_KEY=base64:your-app-key
APP_DEBUG=false
APP_URL=https://your-domain.com

SESSION_DRIVER=file
SESSION_LIFETIME=120
```

### Database Configuration (if using database)
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=msme_finance
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

## File Structure for Deployment
```
msme-finance-market/
├── app/
├── bootstrap/
├── config/
├── database/
├── public/
├── resources/
├── routes/
├── storage/
│   └── app/
│       └── json/          # JSON data files
├── vendor/
├── .env.example
├── composer.json
├── artisan
└── README.md
```

## Data Management
The application uses JSON files for data storage. Ensure these files are properly configured:

- `storage/app/json/users.json` - User credentials
- `storage/app/json/msme_profile.json` - MSME profile data
- `storage/app/json/offers.json` - Loan offers
- `storage/app/json/msmes.json` - MSME listings
- `storage/app/json/rfps.json` - Procurement requests
- `storage/app/json/bids.json` - Bid submissions

## Security Considerations
1. Set `APP_DEBUG=false` in production
2. Generate a strong `APP_KEY`
3. Use HTTPS in production
4. Configure proper file permissions
5. Set up proper session handling

## Monitoring and Maintenance
- Use `./automate-data.sh health` to check system health
- Use `./automate-data.sh backup` to backup data
- Monitor logs in `storage/logs/`

## Troubleshooting
1. Check Laravel logs: `tail -f storage/logs/laravel.log`
2. Verify file permissions: `chmod -R 755 storage/`
3. Clear cache: `php artisan cache:clear`
4. Regenerate config: `php artisan config:cache`

## Support
For issues and questions:
- GitHub: https://github.com/satyam102006
- Email: [Your Email]
- Project: https://github.com/satyam102006/msme-finance-market
EOF

    print_success "Deployment documentation created"
}

# Function to create GitHub repository
create_github_repo() {
    print_status "Setting up GitHub repository..."
    
    # Check if GitHub CLI is installed
    if command -v gh &> /dev/null; then
        print_status "Using GitHub CLI to create repository..."
        
        # Create repository
        gh repo create "$GITHUB_REPO" \
            --public \
            --description "MSME Finance Market - A comprehensive financial marketplace for MSMEs, lenders, and buyers" \
            --homepage "https://satyam102006.github.io/msme-finance-market" \
            --source=. \
            --remote=origin \
            --push
        
        print_success "GitHub repository created and code pushed!"
    else
        print_warning "GitHub CLI not found. Please install it or manually create the repository."
        print_status "Manual steps:"
        echo "1. Go to https://github.com/new"
        echo "2. Create repository: $GITHUB_REPO"
        echo "3. Run: git remote add origin https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git"
        echo "4. Run: git push -u origin main"
    fi
}

# Function to create GitHub Pages deployment
setup_github_pages() {
    print_status "Setting up GitHub Pages deployment..."
    
    # Create GitHub Actions workflow for GitHub Pages
    mkdir -p .github/workflows
    
    cat > .github/workflows/github-pages.yml << 'EOF'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup PHP
      uses: shivammathur/setup-php@v2
      with:
        php-version: '8.2'
        extensions: mbstring, xml, ctype, iconv, intl, pdo_sqlite, dom, filter, gd, iconv, json, mbstring, pdo, session, simplexml, tokenizer, xml, xmlreader, xmlwriter, zip, curl, fileinfo, openssl, phar
        coverage: none
    
    - name: Install Composer
      run: |
        curl -sS https://getcomposer.org/installer | php
        sudo mv composer.phar /usr/local/bin/composer
    
    - name: Install Dependencies
      run: composer install --no-dev --optimize-autoloader
    
    - name: Setup Laravel
      run: |
        cp .env.example .env
        php artisan key:generate
        php artisan config:cache
        php artisan route:cache
        php artisan view:cache
    
    - name: Build Static Site
      run: |
        mkdir -p public_html
        cp -r public/* public_html/
        cp -r storage/app/json public_html/data/
        echo "MSME Finance Market - Static Demo" > public_html/index.html
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      if: github.ref == 'refs/heads/main'
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./public_html
EOF

    print_success "GitHub Pages workflow created"
}

# Function to create Heroku deployment
setup_heroku() {
    print_status "Setting up Heroku deployment..."
    
    # Create Procfile for Heroku
    cat > Procfile << 'EOF'
web: vendor/bin/heroku-php-apache2 public/
EOF

    # Create .env.production
    cat > .env.production << 'EOF'
APP_NAME="MSME Finance Market"
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app-name.herokuapp.com

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

SESSION_DRIVER=file
SESSION_LIFETIME=120

CACHE_DRIVER=file
QUEUE_CONNECTION=sync
EOF

    print_success "Heroku configuration created"
}

# Function to create Vercel deployment
setup_vercel() {
    print_status "Setting up Vercel deployment..."
    
    # Create vercel.json
    cat > vercel.json << 'EOF'
{
  "version": 2,
  "builds": [
    {
      "src": "public/index.php",
      "use": "@vercel/php"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "public/index.php"
    }
  ],
  "env": {
    "APP_ENV": "production",
    "APP_DEBUG": "false"
  }
}
EOF

    print_success "Vercel configuration created"
}

# Function to create Railway deployment
setup_railway() {
    print_status "Setting up Railway deployment..."
    
    # Create railway.json
    cat > railway.json << 'EOF'
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "php artisan serve --host=0.0.0.0 --port=$PORT",
    "healthcheckPath": "/",
    "healthcheckTimeout": 100,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
EOF

    print_success "Railway configuration created"
}

# Function to create DigitalOcean App Platform deployment
setup_digitalocean() {
    print_status "Setting up DigitalOcean App Platform deployment..."
    
    # Create .do/app.yaml
    mkdir -p .do
    cat > .do/app.yaml << 'EOF'
name: msme-finance-market
services:
- name: web
  source_dir: /
  github:
    repo: satyam102006/msme-finance-market
    branch: main
  run_command: php artisan serve --host 0.0.0.0 --port $PORT
  environment_slug: php
  instance_count: 1
  instance_size_slug: basic-xxs
  envs:
  - key: APP_ENV
    value: production
  - key: APP_DEBUG
    value: "false"
  - key: APP_KEY
    value: ${APP_KEY}
  - key: APP_URL
    value: ${APP_URL}
EOF

    print_success "DigitalOcean App Platform configuration created"
}

# Function to create comprehensive README
create_comprehensive_readme() {
    print_status "Creating comprehensive README..."
    
    cat > README.md << 'EOF'
# 🏦 MSME Finance Market

A comprehensive financial marketplace platform connecting MSMEs, lenders, and buyers. Built with Laravel 11 and modern web technologies.

![MSME Finance Market](https://img.shields.io/badge/Laravel-11-red?style=for-the-badge&logo=laravel)
![PHP](https://img.shields.io/badge/PHP-8.2-blue?style=for-the-badge&logo=php)
![TailwindCSS](https://img.shields.io/badge/TailwindCSS-3.0-38B2AC?style=for-the-badge&logo=tailwind-css)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## 🌟 Features

### 🏢 MSME Dashboard
- **Business Profile Management**: Complete business information and compliance tracking
- **Financial Analytics**: Turnover trends, cash flow analysis, and GST filing status
- **Loan Offer Comparison**: AI-powered loan offer recommendations with fit scores
- **Procurement Opportunities**: Browse and bid on RFPs from buyers
- **Compliance Tracking**: PAN, GSTIN, and UDYAM verification status

### 🏦 Lender Dashboard
- **MSME Discovery**: Browse and filter MSMEs by industry, turnover, and compliance
- **Loan Offer Creation**: Submit customized loan offers with terms and conditions
- **Risk Assessment**: AI-powered risk scoring and compliance evaluation
- **Portfolio Management**: Track active offers and their status

### 🛒 Buyer Dashboard
- **RFP Management**: Post procurement requests with detailed specifications
- **Bid Evaluation**: Review and compare bids with AI-powered fit scoring
- **Supplier Discovery**: Find qualified MSME suppliers
- **Procurement Analytics**: Track procurement performance and supplier ratings

## 🚀 Quick Start

### Prerequisites
- PHP 8.1 or higher
- Composer
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/satyam102006/msme-finance-market.git
   cd msme-finance-market
   ```

2. **Automated Setup**
   ```bash
   chmod +x automate-setup.sh
   ./automate-setup.sh
   ```

3. **Start the application**
   ```bash
   chmod +x start-app.sh
   ./start-app.sh
   ```

4. **Access the application**
   - Open your browser and go to `http://localhost:8000`
   - Use demo credentials to login:
     - **MSME**: msme@example.com / password
     - **Lender**: lender@example.com / password
     - **Buyer**: buyer@example.com / password

## 🛠️ Technology Stack

- **Backend**: Laravel 11 (PHP 8.2)
- **Frontend**: Blade Templates with TailwindCSS
- **Data Storage**: JSON files (no database required)
- **Authentication**: Session-based with role-based access control
- **AI Features**: Mock AI logic for recommendations and scoring
- **Charts**: Chart.js for data visualization

## 📊 Data Structure

The application uses JSON files for data storage:

```
storage/app/json/
├── users.json          # User credentials and roles
├── msme_profile.json   # MSME business profiles
├── offers.json         # Loan offers from lenders
├── msmes.json          # MSME listings for lenders
├── rfps.json           # Procurement requests
└── bids.json           # Bid submissions
```

## 🔧 Configuration

### Environment Variables
```env
APP_NAME="MSME Finance Market"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8000

SESSION_DRIVER=file
SESSION_LIFETIME=120
```

### Role-Based Access Control
- **MSME**: Access to business profile, loan offers, and RFP bidding
- **Lender**: Access to MSME discovery and loan offer creation
- **Buyer**: Access to RFP management and bid evaluation

## 🚀 Deployment Options

### 1. Local Development
```bash
./automate-setup.sh
./start-app.sh
```

### 2. GitHub Pages (Static Demo)
```bash
./automate-deploy.sh github-pages
```

### 3. Heroku
```bash
./automate-deploy.sh heroku
```

### 4. Vercel
```bash
./automate-deploy.sh vercel
```

### 5. Railway
```bash
./automate-deploy.sh railway
```

### 6. DigitalOcean App Platform
```bash
./automate-deploy.sh digitalocean
```

## 📈 Data Management

### Automated Data Validation
The application includes automated data validation to prevent errors:

```bash
# Check data health
./automate-data.sh health

# Backup data
./automate-data.sh backup

# Restore data
./automate-data.sh restore

# Generate sample data
./automate-data.sh generate
```

### Data Validation Features
- **Automatic Field Validation**: Ensures all required fields are present
- **Data Type Conversion**: Converts strings to appropriate data types
- **Default Value Assignment**: Provides sensible defaults for missing data
- **Error Prevention**: Prevents "Undefined array key" errors

## 🤖 AI Features

### Loan Offer Comparison
- Analyzes loan terms, interest rates, and processing fees
- Calculates fit scores based on MSME profile
- Provides personalized recommendations

### Bid Evaluation
- Evaluates bid quality based on price, delivery time, and supplier profile
- Calculates fit scores for procurement decisions
- Provides AI-powered supplier recommendations

## 🔒 Security Features

- **Role-Based Access Control**: Secure route protection
- **Session Management**: Secure user sessions
- **Data Validation**: Input sanitization and validation
- **Error Handling**: Comprehensive error management

## 📱 User Interface

### Modern Design
- **Responsive Layout**: Works on desktop, tablet, and mobile
- **TailwindCSS**: Modern utility-first CSS framework
- **Interactive Charts**: Real-time data visualization
- **Intuitive Navigation**: Role-based dashboard layouts

### Dashboard Features
- **Real-time Updates**: Live data refresh
- **Interactive Filters**: Advanced search and filtering
- **Data Export**: Export capabilities for reports
- **Notifications**: System alerts and updates

## 🧪 Testing

### Demo Data
The application includes comprehensive demo data for testing:

- **MSME Profiles**: Complete business profiles with financial data
- **Loan Offers**: Various loan products with different terms
- **RFPs**: Sample procurement requests
- **Bids**: Sample bid submissions

### Test Credentials
```
MSME User:
- Email: msme@example.com
- Password: password

Lender User:
- Email: lender@example.com
- Password: password

Buyer User:
- Email: buyer@example.com
- Password: password
```

## 📚 API Documentation

### Authentication Endpoints
- `POST /login` - User authentication
- `POST /logout` - User logout

### Dashboard Endpoints
- `GET /dashboard/msme` - MSME dashboard
- `GET /dashboard/lender` - Lender dashboard
- `GET /dashboard/buyer` - Buyer dashboard

### Data Endpoints
- `POST /offers` - Submit loan offer
- `POST /rfps` - Post RFP
- `POST /bids` - Submit bid

## 🔧 Development

### Project Structure
```
msme-finance-market/
├── app/
│   ├── Console/Commands/
│   ├── Helpers/
│   └── Http/
│       ├── Controllers/
│       └── Middleware/
├── resources/views/
│   ├── auth/
│   ├── layouts/
│   ├── msme/
│   ├── lender/
│   └── buyer/
├── storage/app/json/
├── routes/
└── public/
```

### Key Components
- **Controllers**: Handle business logic and data processing
- **Middleware**: Authentication and role-based access control
- **Helpers**: AI logic and data validation utilities
- **Views**: Blade templates with TailwindCSS styling

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Satyam Yadav**
- GitHub: [@satyam102006](https://github.com/satyam102006)
- Twitter: [@SatyamYada3175](https://twitter.com/SatyamYada3175)
- LeetCode: [Satyam_9871355050](https://leetcode.com/u/Satyam%5F9871355050/)

## 🙏 Acknowledgments

- Laravel team for the amazing framework
- TailwindCSS for the beautiful styling
- Chart.js for data visualization
- All contributors and supporters

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact: [Your Email]
- Project: https://github.com/satyam102006/msme-finance-market

---

⭐ **Star this repository if you find it helpful!**
EOF

    print_success "Comprehensive README created"
}

# Function to create LICENSE file
create_license() {
    print_status "Creating MIT License file..."
    
    cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 Satyam Yadav

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

    print_success "MIT License created"
}

# Function to prepare for deployment
prepare_deployment() {
    print_status "Preparing for deployment..."
    
    # Run data validation
    ./automate-data.sh health
    
    # Clear caches
    php artisan cache:clear
    php artisan config:clear
    php artisan route:clear
    php artisan view:clear
    
    # Optimize for production
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
    
    print_success "Deployment preparation completed"
}

# Function to commit and push to GitHub
commit_and_push() {
    print_status "Committing and pushing to GitHub..."
    
    # Add all files
    git add .
    
    # Commit with descriptive message
    git commit -m "🚀 Initial commit: MSME Finance Market v1.0

✨ Features:
- Complete MSME, Lender, and Buyer dashboards
- JSON-based data storage (no database required)
- AI-powered loan offer comparison and bid evaluation
- Automated data validation and error prevention
- Role-based access control
- Modern UI with TailwindCSS and Chart.js
- Comprehensive deployment automation

🔧 Technical Stack:
- Laravel 11 with PHP 8.2
- Session-based authentication
- Automated data validation system
- Multiple deployment options (GitHub Pages, Heroku, Vercel, Railway, DigitalOcean)

📊 Demo Data:
- Complete MSME profiles with financial analytics
- Sample loan offers and RFPs
- AI-powered recommendations and scoring

🎯 Ready for deployment to multiple platforms!"

    # Push to GitHub
    git push -u origin main
    
    print_success "Code successfully pushed to GitHub!"
}

# Function to show deployment status
show_deployment_status() {
    print_header
    echo
    print_success "🎉 Deployment completed successfully!"
    echo
    echo -e "${CYAN}📋 Deployment Summary:${NC}"
    echo "  • Repository: https://github.com/$GITHUB_USERNAME/$GITHUB_REPO"
    echo "  • Live Demo: https://satyam102006.github.io/msme-finance-market"
    echo "  • Documentation: https://github.com/$GITHUB_USERNAME/$GITHUB_REPO#readme"
    echo
    echo -e "${CYAN}🚀 Next Steps:${NC}"
    echo "  1. Visit your GitHub repository"
    echo "  2. Enable GitHub Pages in repository settings"
    echo "  3. Choose your preferred deployment platform"
    echo "  4. Configure environment variables"
    echo "  5. Deploy to production"
    echo
    echo -e "${CYAN}📞 Support:${NC}"
    echo "  • GitHub Issues: https://github.com/$GITHUB_USERNAME/$GITHUB_REPO/issues"
    echo "  • Documentation: https://github.com/$GITHUB_USERNAME/$GITHUB_REPO#readme"
    echo
    print_success "Your MSME Finance Market is now live on GitHub! 🎊"
}

# Main deployment function
deploy() {
    print_header
    
    case $DEPLOYMENT_TYPE in
        "github-pages")
            print_status "Setting up GitHub Pages deployment..."
            setup_github_pages
            ;;
        "heroku")
            print_status "Setting up Heroku deployment..."
            setup_heroku
            ;;
        "vercel")
            print_status "Setting up Vercel deployment..."
            setup_vercel
            ;;
        "railway")
            print_status "Setting up Railway deployment..."
            setup_railway
            ;;
        "digitalocean")
            print_status "Setting up DigitalOcean App Platform deployment..."
            setup_digitalocean
            ;;
        "all"|"")
            print_status "Setting up all deployment options..."
            setup_github_pages
            setup_heroku
            setup_vercel
            setup_railway
            setup_digitalocean
            ;;
        *)
            print_error "Invalid deployment type: $DEPLOYMENT_TYPE"
            echo "Available options: github-pages, heroku, vercel, railway, digitalocean, all"
            exit 1
            ;;
    esac
    
    print_success "Deployment configuration completed!"
}

# Main script execution
main() {
    DEPLOYMENT_TYPE=${1:-"all"}
    
    print_header
    echo
    print_status "Starting deployment process..."
    echo
    
    # Check prerequisites
    check_prerequisites
    
    # Initialize Git repository
    init_git_repo
    
    # Create necessary files
    create_gitignore
    create_deployment_docs
    create_comprehensive_readme
    create_license
    
    # Prepare for deployment
    prepare_deployment
    
    # Setup deployment configurations
    deploy
    
    # Create GitHub repository and push code
    create_github_repo
    commit_and_push
    
    # Show final status
    show_deployment_status
}

# Run main function with all arguments
main "$@" 