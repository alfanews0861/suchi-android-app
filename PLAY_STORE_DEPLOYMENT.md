# 🚀 Suchi Android App - Play Store Deployment Guide

## 📦 Release Files Generated

### ✅ Android App Bundle (AAB) - For Play Store
**File:** `/workspaces/suchi-android-app/android/app/build/outputs/bundle/release/app-release.aab`  
**Size:** 3.3 MB  
**Use:** Upload directly to Google Play Console

### ✅ Release APK - For Direct Distribution
**File:** `/workspaces/suchi-android-app/android/app/build/outputs/apk/release/app-release.apk`  
**Size:** 3.6 MB  
**Use:** Share directly with users (outside Play Store)

---

## 🔑 Signing Credentials

### Keystore Details
- **File:** `suchi-release-key.jks` (in project root)
- **Alias:** `suchi-key`
- **Store Password:** `suchi@2025`
- **Key Password:** `suchi@2025`
- **Validity:** 10,000 days (until ~2052)

### SHA-1 Fingerprints
**Debug Keystore:**
```
SHA-1: B7:51:4C:66:BF:29:19:B7:69:2E:74:C0:47:C5:D2:1F:70:31:A3:F9
```

**Release Keystore:**
```
SHA-1: DA:8C:2E:B8:E9:7C:11:55:C0:D5:1E:BC:81:56:BA:DE:20:30:AA:0A
```

⚠️ **IMPORTANT:** Keep `suchi-release-key.jks` file safe! Store it securely - you cannot update the app without it.

---

## 🔥 Firebase Configuration

### Required: Add Release SHA-1 to Firebase
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **suchi-6007b**
3. **⚙️ Project Settings** → **General** tab
4. Scroll to **Your apps** → Select Android app (`com.suchi.app`)
5. Click **"Add fingerprint"**
6. Paste Release SHA-1:
   ```
   DA:8C:2E:B8:E9:7C:11:55:C0:D5:1E:BC:81:56:BA:DE:20:30:AA:0A
   ```
7. Click **Save**

**Why?** Phone authentication won't work without adding the release SHA-1!

---

## 📱 Play Store Upload Instructions

### Step 1: Create Play Console Account
1. Go to [Google Play Console](https://play.google.com/console)
2. Pay one-time $25 registration fee
3. Complete account verification

### Step 2: Create App
1. Click **"Create app"**
2. Fill in:
   - **App name:** Suchi - Freshness Delivered
   - **Default language:** English (or Telugu)
   - **App type:** App
   - **Free or paid:** Free
3. Accept declarations

### Step 3: Set Up App Details
1. **Store listing:**
   - Short description (80 chars)
   - Full description (4000 chars)
   - App icon (512x512 PNG)
   - Feature graphic (1024x500 PNG)
   - Screenshots (at least 2)
   - App category: Shopping
   
2. **Content rating:**
   - Fill questionnaire
   - Get rating certificate

3. **Target audience:**
   - Age group
   - Content guidelines

4. **Privacy policy:**
   - Provide URL to privacy policy

### Step 4: Upload AAB
1. Go to **Production** → **Create new release**
2. Upload `app-release.aab`
3. Set version name: **1.0**
4. Set version code: **1**
5. Add release notes:
   ```
   Initial release
   - Browse fresh fruits and vegetables
   - Phone number authentication
   - Order management
   - Real-time delivery tracking
   ```

### Step 5: Review and Publish
1. Complete all required sections (marked with !)
2. Click **"Review release"**
3. Click **"Start rollout to Production"**
4. Wait for Google review (1-7 days)

---

## 🧪 Testing Before Release

### Install Release APK
```bash
adb install app-release.apk
```

### Test Checklist
- ✅ App opens with orange splash screen
- ✅ Website loads in WebView
- ✅ Phone authentication works
- ✅ No crashes
- ✅ Signing is correct

---

## 🔄 Future Updates

### To Build New Version:
1. Update version in `android/app/build.gradle`:
   ```gradle
   versionCode 2  // Increment by 1
   versionName "1.1"  // Update version name
   ```

2. Make your code changes

3. Build new AAB:
   ```bash
   cd android
   ./gradlew bundleRelease
   ```

4. Upload new AAB to Play Console

---

## 📋 App Information

- **Package Name:** `com.suchi.app`
- **App Name:** Suchi
- **Theme Color:** #FF6B35 (Orange)
- **Target SDK:** 34
- **Min SDK:** 23 (Android 6.0+)
- **Website:** https://suchi-freshness-delivered-281434672237.us-west1.run.app/

---

## 🎨 Features Included

✅ **Custom Splash Screen** - Orange background with logo  
✅ **WebView Integration** - Full website in native app  
✅ **Google Auth Plugin** - For phone authentication  
✅ **Firebase Integration** - Backend authentication  
✅ **Signed Release Build** - Ready for Play Store  
✅ **No Action Bar** - Clean full-screen experience  

---

## 📞 Support

For any build issues or updates, refer to:
- Firebase Console: https://console.firebase.google.com/
- Play Console: https://play.google.com/console
- Capacitor Docs: https://capacitorjs.com/

---

**Generated:** October 29, 2025  
**Build System:** Gradle 8.11.1  
**Framework:** Capacitor 7.4.4
