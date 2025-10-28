# Suchi Android WebView App

ఈ యాప్ Suchi వెబ్‌సైట్‌ను (https://suchi-freshness-delivered-281434672237.us-west1.run.app/) ఆండ్రాయిడ్ WebView లో చూపిస్తుంది. ఇది పూర్తిగా నేటివ్ ఆండ్రాయిడ్ అప్లికేషన్ లాగా కనిపిస్తుంది.

## Features / లక్షణాలు

- ✅ WebView integration without address bar (అడ్రస్ బార్ లేకుండా WebView)
- ✅ Google Sign-In support (గూగుల్ సైన్ ఇన్ సపోర్ట్)
- ✅ Mobile number authentication (మొబైల్ నంబర్ అథెంటికేషన్)
- ✅ Native Android look and feel (నేటివ్ ఆండ్రాయిడ్ లుక్)
- ✅ Swipe to refresh (స్వైప్ టు రిఫ్రెష్)
- ✅ Back button navigation (బ్యాక్ బటన్ నావిగేషన్)
- ✅ Progress bar for loading (లోడింగ్ ప్రోగ్రెస్ బార్)

## Prerequisites / అవసరాలు

### 1. Java Development Kit (JDK)
```powershell
# Check if Java is installed
java -version

# If not installed, download from:
# https://www.oracle.com/java/technologies/downloads/
```

### 2. Android SDK Command Line Tools (Optional)
If you want to sign the APK with your own keystore, you'll need Android SDK.

## Build Instructions / బిల్డ్ చేయడానికి

### 🎯 Recommended Method: GitHub Actions (Online Build)

Due to Java compatibility issues with local Gradle, the **GitHub Actions method is recommended**:

1. **Setup Git (if not installed)**
```powershell
# Download Git from: https://git-scm.com/download/win
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

2. **Upload to GitHub**
```powershell
# Already initialized in project directory
git add .
git commit -m "Suchi Android WebView App"

# Create repository on GitHub.com, then:
git remote add origin https://github.com/YOUR_USERNAME/suchi-android-app.git
git branch -M main
git push -u origin main
```

3. **Automatic APK Build**
- GitHub Actions will automatically build your APK
- Check the "Actions" tab on your GitHub repository
- Download APK from "Artifacts" section when build completes

### Method 2: Local Build (if you fix Java compatibility)

Install Java JDK 11 instead of Java 21:
1. Download from: https://adoptium.net/temurin/releases/
2. Set JAVA_HOME to JDK 11 path
3. Run: `.\gradlew.bat assembleRelease`

### Method 3: Online APK Builders

Alternative online services:
- **ApkBuilder.me** - Upload source code directory
- **Replit.com** - Online Android development environment

## APK Locations / APK ఫైల్స్ లొకేషన్

After successful build:

- **Debug APK**: `app\build\outputs\apk\debug\app-debug.apk`
- **Release APK**: `app\build\outputs\apk\release\app-release.apk`

## Installation / ఇన్‌స్టాలేషన్

### Install on Android Device:

1. **Enable Developer Options**
   - Settings → About Phone → tap "Build Number" 7 times

2. **Enable USB Debugging**
   - Settings → Developer Options → USB Debugging

3. **Install APK**
```powershell
# If you have ADB installed
adb install app\build\outputs\apk\release\app-release.apk

# Or copy APK to phone and install manually
```

### Install via File Transfer:
1. Copy the APK file to your Android device
2. Open the APK file on your device
3. Enable "Install from Unknown Sources" if prompted
4. Install the app

## Features Explained / లక్షణాల వివరణ

### WebView Configuration
- JavaScript enabled for full website functionality
- Local storage enabled for login persistence
- Custom User Agent for mobile optimization
- Mixed content allowed for HTTPS/HTTP resources

### Google Sign-In Integration
- The app includes Google Sign-In SDK
- JavaScript interface allows website to trigger native Google Sign-In
- User credentials are shared between native app and website

### Native Android Experience
- No address bar or browser controls visible
- Native Android status bar and navigation
- Material Design theming with Suchi brand colors
- Swipe-to-refresh functionality
- Hardware back button support

### Network Handling
- Automatic retry on network errors
- Loading progress indication
- Pull-to-refresh for manual reload
- Handles different network conditions

## Customization / కస్టమైజేషన్

### Change App Name
Edit `app/src/main/res/values/strings.xml`:
```xml
<string name="app_name">Your App Name</string>
```

### Change Colors
Edit `app/src/main/res/values/colors.xml`:
```xml
<color name="suchi_primary">#YOUR_COLOR</color>
```

### Change Website URL
Edit `MainActivity.java`:
```java
private static final String WEBSITE_URL = "https://your-website.com/";
```

### Add App Icon
Replace files in `app/src/main/res/mipmap-*` directories with your icon files.

## Troubleshooting / ట్రబుల్‌షూటింగ్

### Build Errors

**Java not found:**
```
ERROR: Java is not installed or not in PATH
```
**Solution:** Install Java JDK 8 or higher and add to PATH.

**Gradle download fails:**
```
Could not download gradle-wrapper.jar
```
**Solution:** Check internet connection and try again.

**Permission denied:**
```
gradlew.bat: Permission denied
```
**Solution:** Run PowerShell as Administrator.

### App Installation Issues

**App not installing:**
- Enable "Install from Unknown Sources" in Android settings
- Check if you have enough storage space
- Try uninstalling previous version first

**App crashes on startup:**
- Check if device has internet connection
- Ensure Android version is 7.0 (API 24) or higher

### WebView Issues

**Website not loading:**
- Check internet connection
- Verify website URL is correct
- Check if website is accessible from mobile browser

**Google Sign-In not working:**
- Ensure Google Play Services are installed
- Check if device supports Google Sign-In
- Verify network connectivity

## Advanced Configuration / అడ్వాన్స్‌డ్ కాన్ఫిగరేషన్

### Custom Signing (for Play Store)

1. **Generate keystore:**
```powershell
keytool -genkey -v -keystore suchi-release-key.keystore -alias suchi -keyalg RSA -keysize 2048 -validity 10000
```

2. **Add to app/build.gradle:**
```gradle
android {
    signingConfigs {
        release {
            storeFile file('suchi-release-key.keystore')
            storePassword 'your-store-password'
            keyAlias 'suchi'
            keyPassword 'your-key-password'
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### ProGuard Configuration
To enable code obfuscation, edit `app/build.gradle`:
```gradle
buildTypes {
    release {
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

## Project Structure / ప్రాజెక్ట్ స్ట్రక్చర్

```
suchi102825/
├── app/
│   ├── src/main/
│   │   ├── java/com/suchi/app/
│   │   │   ├── MainActivity.java          # Main WebView activity
│   │   │   └── WebAppInterface.java       # JavaScript bridge
│   │   ├── res/
│   │   │   ├── layout/
│   │   │   │   └── activity_main.xml      # Main layout
│   │   │   ├── values/
│   │   │   │   ├── colors.xml             # App colors
│   │   │   │   ├── strings.xml            # App strings
│   │   │   │   └── themes.xml             # App themes
│   │   │   └── mipmap-*/                  # App icons
│   │   └── AndroidManifest.xml            # App manifest
│   ├── build.gradle                       # App build config
│   └── proguard-rules.pro                 # ProGuard rules
├── gradle/wrapper/                        # Gradle wrapper
├── build.gradle                           # Root build config
├── settings.gradle                        # Project settings
├── gradle.properties                      # Gradle properties
├── gradlew.bat                           # Gradle wrapper (Windows)
├── build.bat                             # Build script
└── README.md                             # This file
```

## Support / సపోర్ట్

For issues or questions:
1. Check the troubleshooting section above
2. Ensure all prerequisites are installed
3. Try cleaning and rebuilding: `.\gradlew.bat clean assembleRelease`

## License / లైసెన్స్

This project is created for Suchi app development. Modify as needed for your requirements.

---

**Build Date:** October 28, 2025  
**Version:** 1.0  
**Target Android:** API 24+ (Android 7.0+)  
**Compile SDK:** API 34 (Android 14)