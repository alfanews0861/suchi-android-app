# Firebase Setup Instructions for Suchi Android App

## పరిస్థితి (Current Issue)
Google Sign-In మరియు OTP ద్వారా mobile number authentication పని చేయడం లేదు. ఇది google-services.json file లేకపోవడం వల్ల లేదా SHA1 fingerprint తప్పుగా ఉండటం వల్ల కావచ్చు.

## అవసరమైన Files
- ✅ google-services.json (మీరు Firebase console నుండి download చేయాలి)
- ✅ SHA1 fingerprint (debug: `B7:51:4C:66:BF:29:19:B7:69:2E:74:C0:47:C5:D2:1F:70:31:A3:F9`)

## Step-by-Step Setup Instructions

### 1. Firebase Project Setup
1. [Firebase Console](https://console.firebase.google.com/) కి వెళ్ళండి
2. "Add project" click చేయండి
3. Project name: "suchi-android-app" లేదా మీ ఇష్టం
4. Google Analytics enable చేయండి (optional)

### 2. Android App Configuration
1. Firebase project లో "Add app" > Android icon click చేయండి
2. Package name: `com.suchi.app` (exactly ఇది వాడండి)
3. App nickname: "Suchi App"
4. SHA-1 certificates add చేయండి:
   - Debug SHA1: `B7:51:4C:66:BF:29:19:B7:69:2E:74:C0:47:C5:D2:1F:70:31:A3:F9`
   - Release SHA1: (మీరు release keystore generate చేసిన తర్వాత add చేయండి)

### 3. google-services.json Download
1. Firebase console లో "Download google-services.json" click చేయండి
2. Downloaded file ని `/workspaces/suchi-android-app/app/` folder లో పెట్టండి
3. Existing `google-services.json.template` file ని delete చేయండి లేదా rename చేయండి

### 4. Authentication Setup
1. Firebase console లో "Authentication" section కి వెళ్ళండి
2. "Get started" click చేయండి
3. "Sign-in method" tab లో:
   - **Google**: Enable చేయండి
   - **Phone**: Enable చేయండి (OTP కోసం)

### 5. Google Sign-In Configuration
1. Authentication > Sign-in method > Google లో:
   - Project support email add చేయండి
   - Web SDK configuration లో OAuth client ID note చేసుకోండి
2. Google Cloud Console లో కూడా same SHA1 fingerprints add చేయండి

### 6. Phone Authentication Setup (OTP)
1. Authentication > Sign-in method > Phone లో enable చేయండి
2. Test phone numbers add చేయవచ్చు (development కోసం)

### 7. Release Keystore SHA1 Generation
Release APK కోసం separate keystore మరియు SHA1 fingerprint అవసరం:

```bash
# Generate release keystore
keytool -genkey -v -keystore release-key.keystore -alias release -keyalg RSA -keysize 2048 -validity 10000

# Get SHA1 fingerprint for release
keytool -list -v -keystore release-key.keystore -alias release
```

## Troubleshooting Common Issues

### Issue 1: Google Sign-In Failed
**కారణం**: google-services.json లేదా SHA1 fingerprint తప్పు
**పరిష్కారం**:
1. Correct google-services.json file ఉందో check చేయండి
2. Firebase console లో SHA1 fingerprint correct గా add చేశారో verify చేయండి
3. App rebuild చేయండి

### Issue 2: OTP Not Received
**కారణం**: Phone authentication properly configured లేదు
**పరిష్కారం**:
1. Firebase console లో Phone authentication enable చేశారో check చేయండి
2. Test phone numbers లో మీ number add చేయండి
3. Google Play Services updated ఉందో check చేయండి

### Issue 3: "Default web client ID not found"
**కారణం**: google-services.json లో web client ID లేదు
**పరిష్కారం**:
1. Firebase console లో Authentication > Settings > Web SDK configuration check చేయండి
2. google-services.json file re-download చేయండి

## Files Modified
- ✅ `/app/build.gradle` - Firebase dependencies added
- ✅ `/build.gradle` - Google services plugin added
- ✅ `/app/src/main/java/com/suchi/app/MainActivity.java` - Firebase Auth integration
- ⚠️ `/app/google-services.json` - **మీరు Firebase console నుండి download చేయాలి**

## Verification Steps
1. App build అవుతుందో check చేయండి: `./gradlew assembleDebug`
2. LogCat లో Firebase initialization messages చూడండి
3. Google Sign-In button test చేయండి
4. Phone number OTP test చేయండి

## Important Notes
- Debug మరియు Release రెండు కోసం వేరు వేరు SHA1 fingerprints అవసరం
- google-services.json file లేకుండా app proper గా పని చేయదు
- Firebase project లో same package name (`com.suchi.app`) use చేయాలి
- Internet connection అవసరం authentication కోసం

## Contact for Issues
Firebase console లో project setup చేసిన తర్వాత కూడా issues వస్తే:
1. LogCat errors share చేయండి
2. Firebase console screenshots share చేయండి
3. google-services.json file properly placed ఉందో confirm చేయండి