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
