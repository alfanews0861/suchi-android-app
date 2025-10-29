#!/bin/bash

echo "🔍 Suchi Android App - Configuration Check"
echo "=========================================="

# Check if google-services.json exists
if [ -f "app/google-services.json" ]; then
    echo "✅ google-services.json found"
    echo "   Package name in file:"
    grep -o '"package_name": "[^"]*"' app/google-services.json | head -1
else
    echo "❌ google-services.json NOT found"
    echo "   Please download from Firebase Console and place in app/ folder"
fi

echo ""

# Check build.gradle files
echo "🔧 Build Configuration:"
if grep -q "com.google.gms.google-services" build.gradle; then
    echo "✅ Google Services plugin found in root build.gradle"
else
    echo "❌ Google Services plugin missing in root build.gradle"
fi

if grep -q "com.google.gms.google-services" app/build.gradle; then
    echo "✅ Google Services plugin applied in app build.gradle"
else
    echo "❌ Google Services plugin not applied in app build.gradle"
fi

if grep -q "firebase-auth" app/build.gradle; then
    echo "✅ Firebase Auth dependency found"
else
    echo "❌ Firebase Auth dependency missing"
fi

echo ""

# Check SHA1 fingerprint
echo "🔐 SHA1 Fingerprint (Debug):"
if [ -f ~/.android/debug.keystore ]; then
    echo "Debug keystore found. SHA1:"
    keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 2>/dev/null | grep "SHA1:" | head -1
else
    echo "❌ Debug keystore not found"
fi

echo ""

# Check if app compiles
echo "🛠️  Compilation Test:"
if command -v ./gradlew &> /dev/null; then
    echo "Running compilation test..."
    if ./gradlew assembleDebug --quiet 2>/dev/null; then
        echo "✅ App compiles successfully"
    else
        echo "❌ Compilation failed - check the errors above"
    fi
else
    echo "⚠️  Gradle wrapper not found, skipping compilation test"
fi

echo ""
echo "📋 Next Steps:"
echo "1. If google-services.json is missing, download it from Firebase Console"
echo "2. Make sure SHA1 fingerprint is added to Firebase project"
echo "3. Enable Authentication > Google and Phone in Firebase Console"
echo "4. Test the app after fixing any issues"

echo ""
echo "For detailed setup instructions, see: FIREBASE_SETUP_GUIDE.md"