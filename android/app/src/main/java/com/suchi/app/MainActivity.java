package com.suchi.app;

import android.os.Bundle;
import android.webkit.WebSettings;
import android.webkit.WebView;
import com.getcapacitor.BridgeActivity;
import com.getcapacitor.Bridge;

public class MainActivity extends BridgeActivity {
    
    private static final String WEBSITE_URL = "https://suchi-freshness-delivered-281434672237.us-west1.run.app";
    
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Configure WebView for better compatibility
        configureWebView();
        
        android.util.Log.d("MainActivity", "MainActivity created with Native Google Auth support");
    }
    
    @Override
    public void onStart() {
        super.onStart();
        
        android.util.Log.d("MainActivity", "App started - loading website");
        
        // Load website directly in WebView
        Bridge bridge = this.getBridge();
        if (bridge != null) {
            WebView webView = bridge.getWebView();
            if (webView != null) {
                android.util.Log.d("MainActivity", "Loading website in WebView");
                webView.loadUrl(WEBSITE_URL);
            }
        }
    }
    
    private void configureWebView() {
        Bridge bridge = this.getBridge();
        if (bridge != null) {
            WebView webView = bridge.getWebView();
            if (webView != null) {
                WebSettings settings = webView.getSettings();
                
                // Enable JavaScript
                settings.setJavaScriptEnabled(true);
                settings.setJavaScriptCanOpenWindowsAutomatically(true);
                
                // Enable DOM storage
                settings.setDomStorageEnabled(true);
                settings.setDatabaseEnabled(true);
                
                // Allow file access
                settings.setAllowFileAccess(true);
                settings.setAllowContentAccess(true);
                
                // Enable mixed content
                settings.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
                
                // Enable third-party cookies
                android.webkit.CookieManager cookieManager = android.webkit.CookieManager.getInstance();
                cookieManager.setAcceptCookie(true);
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    cookieManager.setAcceptThirdPartyCookies(webView, true);
                }
                
                // Set user agent
                String userAgent = settings.getUserAgentString();
                settings.setUserAgentString(userAgent + " SuchiApp/1.0");
                
                // Enable caching
                settings.setCacheMode(WebSettings.LOAD_DEFAULT);
                
                // Enable support for multiple windows
                settings.setSupportMultipleWindows(true);
                
                // Enable geolocation
                settings.setGeolocationEnabled(true);
                
                // Disable safe browsing
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                    settings.setSafeBrowsingEnabled(false);
                }
                
                android.util.Log.d("MainActivity", "WebView configured");
            }
        }
    }
}
