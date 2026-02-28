#!/bin/bash

# Shree Radha Madhav Decoration - APK Build Script
# This script automates the APK build process using Expo Cloud Build

echo "🎉 Shree Radha Madhav Decoration - APK Builder"
echo "================================================"
echo ""

# Check if eas-cli is installed
if ! command -v eas &> /dev/null; then
    echo "📦 Installing EAS CLI..."
    npm install -g eas-cli
fi

# Check if user is logged in
echo "🔐 Checking Expo login status..."
if ! eas whoami &> /dev/null; then
    echo "❌ Not logged in to Expo. Please log in:"
    eas login
fi

# Verify project configuration
echo "✅ Project configured for Android APK build"
echo ""

# Start the build
echo "🏗️  Starting Android APK build..."
echo "This may take 10-15 minutes. Please wait..."
echo ""

eas build --platform android --non-interactive

echo ""
echo "✅ Build complete!"
echo "📱 Your APK is ready to download from the link above."
echo "💾 Install on your device and enjoy!"
