# 🔍 Custom Tabs Debugging Guide

## Issue: Custom Tabs Not Opening
You mentioned that Custom Tabs are not opening. Let's debug this step by step.

## 🚀 **New Debug APK Features**

### **1. Enhanced Logging**
The new APK includes detailed logging. Connect your device and run:
```bash
adb logcat | grep -E "(MainActivity|WebAppInterface|CustomTabs)"
```

### **2. Debug Interface on Website**
After installing the new APK, you'll see debug buttons in the top-right corner of the website:
- **Test Custom Tabs** - Tests Custom Tabs functionality
- **Native Google Sign-In** - Tests native authentication  
- **Open OAuth URL** - Tests with a sample OAuth URL

### **3. Improved URL Detection**
Enhanced OAuth URL detection that checks for:
- `accounts.google.com`
- `oauth`, `auth`, `login`, `signin`
- OAuth parameters like `client_id=`, `response_type=`

## 🧪 **Testing Steps**

### **Step 1: Install Updated APK**
```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

### **Step 2: Enable Logging**
```bash
# In one terminal, watch logs
adb logcat | grep -E "(MainActivity|WebAppInterface|CustomTabs|OAuth)"
```

### **Step 3: Test Debug Buttons**
1. Open the app
2. Look for debug buttons in top-right corner (appear after 3 seconds)
3. Click **"Test Custom Tabs"** button
4. Watch the logs for detailed output

### **Step 4: Test Real OAuth Flow**
1. Click **"Open OAuth URL"** button
2. Should open Custom Tabs with Google OAuth page
3. Check logs for any errors

## 🔍 **Debugging Information**

### **Expected Log Messages:**
```
MainActivity: URL loading intercepted: [URL]
MainActivity: Checking if OAuth URL: [URL]
MainActivity: OAuth check result: true for URL: [URL]
MainActivity: OAuth URL detected, opening in Custom Tabs: [URL]
MainActivity: Attempting to open URI in Custom Tabs: [URL]
MainActivity: Successfully opened Custom Tab for: [URL]
```

### **If Custom Tabs Fail:**
```
MainActivity: Custom Tabs failed: [Error]
MainActivity: No activity found to handle Custom Tabs, falling back to browser
MainActivity: Opened in external browser: [URL]
```

### **Common Issues & Solutions:**

#### **Issue 1: Chrome Not Installed**
- **Symptom**: "No activity found to handle Custom Tabs"
- **Solution**: Install Chrome browser on device
- **Fallback**: Opens in default browser

#### **Issue 2: URL Not Detected as OAuth**
- **Symptom**: URLs load in WebView instead of Custom Tabs
- **Check**: Log shows "OAuth check result: false"
- **Solution**: Check URL patterns, may need to add specific patterns

#### **Issue 3: Custom Tabs Service Unavailable**
- **Symptom**: Custom Tabs intent fails
- **Solution**: Falls back to regular browser automatically

## 🛠️ **Manual Testing Commands**

### **Test via JavaScript Console (Chrome DevTools)**
If you can access the website in Chrome desktop and inspect:
```javascript
// Check if Android interface is available
console.log(typeof window.Android);

// Test Custom Tabs manually
window.Android.testCustomTabs();

// Test with specific URL
window.Android.openOAuthInCustomTab('https://accounts.google.com/oauth/authorize?client_id=test');
```

### **Test via ADB**
```bash
# Launch Custom Tabs directly (test if Chrome supports it)
adb shell am start -a android.intent.action.VIEW -d "https://accounts.google.com" --es android.support.customtabs.extra.SESSION null
```

## 🔧 **Advanced Debugging**

### **Check Chrome Custom Tabs Support:**
```bash
# Check if Chrome Custom Tabs service is available
adb shell "dumpsys package | grep -A 5 'chrome.*customtabs'"
```

### **Check Available Browsers:**
```bash
# List apps that can handle VIEW intents
adb shell "dumpsys package | grep -A 5 'android.intent.action.VIEW'"
```

## 📋 **Expected Behavior After Fix**

### **✅ What Should Happen:**
1. **OAuth URLs Detected** - Logs show OAuth detection
2. **Custom Tabs Open** - Chrome Custom Tabs launches
3. **Fallback Works** - If Custom Tabs fail, opens in browser
4. **Debug Buttons Work** - Test buttons trigger Custom Tabs

### **⚠️ If Still Not Working:**
1. **Check Device Chrome Version** - Update Chrome browser
2. **Check Device Android Version** - Custom Tabs requires Android 4.1+
3. **Check App Permissions** - Ensure app has internet permission
4. **Check WebView Version** - Update Android System WebView

## 🎯 **Next Steps**
1. Install the updated APK
2. Look for debug buttons on the website
3. Test each button and watch logs
4. Report what you see in the logs
5. Tell me if Custom Tabs open or what error occurs

The new APK has comprehensive debugging and fallback mechanisms. Even if Custom Tabs don't work, it should at least open in the regular browser with detailed error logging.

Let me know what the logs show! 🔍