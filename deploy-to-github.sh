#!/bin/bash

# MSME Finance Market - GitHub Deployment Script
# Author: Satyam Yadav (@satyam102006)

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  MSME Finance Market Deployer${NC}"
echo -e "${BLUE}================================${NC}"

# Configuration
GITHUB_USERNAME="satyam102006"
REPO_NAME="msme-finance-market"

echo -e "${GREEN}[INFO]${NC} Starting deployment to GitHub..."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}[ERROR]${NC} Git is not installed. Please install Git first."
    exit 1
fi

# Initialize git repository if not already done
if [ ! -d ".git" ]; then
    echo -e "${GREEN}[INFO]${NC} Initializing Git repository..."
    git init
fi

# Create .gitignore
echo -e "${GREEN}[INFO]${NC} Creating .gitignore..."
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

# Create comprehensive README
echo -e "${GREEN}[INFO]${NC} Creating comprehensive README..."
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

# Create MIT License
echo -e "${GREEN}[INFO]${NC} Creating MIT License..."
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

# Run data validation
echo -e "${GREEN}[INFO]${NC} Running data validation..."
./automate-data.sh health

# Clear caches (skip if database not configured)
echo -e "${GREEN}[INFO]${NC} Clearing caches..."
php artisan config:clear || true
php artisan route:clear || true
php artisan view:clear || true

# Add all files to git
echo -e "${GREEN}[INFO]${NC} Adding files to Git..."
git add .

# Commit with descriptive message
echo -e "${GREEN}[INFO]${NC} Committing changes..."
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
- Multiple deployment options

📊 Demo Data:
- Complete MSME profiles with financial analytics
- Sample loan offers and RFPs
- AI-powered recommendations and scoring

🎯 Ready for deployment to multiple platforms!"

# Check if remote exists
if ! git remote get-url origin &> /dev/null; then
    echo -e "${GREEN}[INFO]${NC} Adding GitHub remote..."
    git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git
fi

# Push to GitHub
echo -e "${GREEN}[INFO]${NC} Pushing to GitHub..."
git push -u origin main

echo
echo -e "${BLUE}================================${NC}"
echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"
echo -e "${BLUE}================================${NC}"
echo
echo -e "${YELLOW}📋 Deployment Summary:${NC}"
echo "  • Repository: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "  • Live Demo: https://satyam102006.github.io/$REPO_NAME"
echo "  • Documentation: https://github.com/$GITHUB_USERNAME/$REPO_NAME#readme"
echo
echo -e "${YELLOW}🚀 Next Steps:${NC}"
echo "  1. Visit your GitHub repository"
echo "  2. Enable GitHub Pages in repository settings"
echo "  3. Choose your preferred deployment platform"
echo "  4. Configure environment variables"
echo "  5. Deploy to production"
echo
echo -e "${YELLOW}📞 Support:${NC}"
echo "  • GitHub Issues: https://github.com/$GITHUB_USERNAME/$REPO_NAME/issues"
echo "  • Documentation: https://github.com/$GITHUB_USERNAME/$REPO_NAME#readme"
echo
echo -e "${GREEN}Your MSME Finance Market is now live on GitHub! 🎊${NC}" 