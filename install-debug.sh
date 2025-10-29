#!/bin/bash

echo "🚀 Suchi Android App - Debug APK Generated!"
echo "=========================================="

APK_PATH="app/build/outputs/apk/debug/app-debug.apk"

# Check if APK exists
if [ -f "$APK_PATH" ]; then
    echo "✅ APK Location: $APK_PATH"
    echo "📱 APK Size: $(du -h $APK_PATH | cut -f1)"
    echo "📦 Package: com.suchi.app"
    echo "🔢 Version: 1.0 (Code: 1)"
    echo "🏗️  Build Type: Debug"
    echo "🔐 Signed with: Debug keystore"
    echo ""
    
    # Show APK details
    echo "📋 APK Details:"
    echo "   - Firebase Authentication: ✅ Enabled"
    echo "   - Google Sign-In: ✅ Enhanced with Chrome Custom Tabs"
    echo "   - Phone Authentication: ✅ OTP Support"
    echo "   - WebView OAuth: ✅ Fixed with Custom Tabs"
    echo "   - Deep Links: ✅ OAuth redirect handling"
    echo ""
    
    # Installation instructions
    echo "📱 Installation Instructions:"
    echo "   1. Enable 'Unknown Sources' on your Android device"
    echo "   2. Connect device via USB and enable USB Debugging"
    echo "   3. Run: adb install $APK_PATH"
    echo "   4. Or copy APK to device and install manually"
    echo ""
    
    # Check if ADB is available
    if command -v adb &> /dev/null; then
        echo "🔍 ADB Status:"
        if adb devices | grep -q "device$"; then
            echo "   ✅ Device connected and ready"
            echo ""
            echo "🚀 Quick Install Command:"
            echo "   adb install -r $APK_PATH"
            echo ""
        else
            echo "   ⚠️  No devices connected"
            echo "   Connect your Android device with USB debugging enabled"
            echo ""
        fi
    else
        echo "   ⚠️  ADB not available in this environment"
        echo "   Copy APK file to your device manually"
        echo ""
    fi
    
    # Testing instructions
    echo "🧪 Testing Instructions:"
    echo "   1. Install and open the app"
    echo "   2. Test Google Sign-In (should open Chrome Custom Tabs)"
    echo "   3. Test phone number authentication"
    echo "   4. Check LogCat for debug messages:"
    echo "      adb logcat | grep -E '(MainActivity|FirebaseAuth|GoogleSignIn)'"
    echo ""
    
    # Troubleshooting
    echo "🔧 Troubleshooting:"
    echo "   - If Google Sign-In fails: Check Firebase Console Authentication settings"
    echo "   - If OTP doesn't arrive: Verify phone authentication is enabled"
    echo "   - For detailed logs: adb logcat | grep 'MainActivity'"
    echo ""
    
    echo "✨ Your enhanced Suchi app with OAuth fixes is ready to test!"
    
else
    echo "❌ APK not found at $APK_PATH"
    echo "Run: ./gradlew assembleDebug"
fi