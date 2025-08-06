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
