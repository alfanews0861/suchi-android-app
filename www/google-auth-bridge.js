// Suchi In-App Browser Authentication
// Opens authentication in a separate WebView window inside the app

(function() {
    'use strict';
    
    console.log('🔐 Suchi In-App Browser Auth Ready');
    
    // Check if Cordova InAppBrowser is available
    if (window.cordova && window.cordova.InAppBrowser) {
        console.log('✅ InAppBrowser plugin available');
        
        // Function to open authentication in in-app browser
        window.openAuthInAppBrowser = function() {
            try {
                console.log('🌐 Opening authentication in in-app browser...');
                
                const authUrl = 'https://suchi-freshness-delivered-281434672237.us-west1.run.app';
                
                // Open in InAppBrowser with specific options
                const inAppBrowserRef = cordova.InAppBrowser.open(
                    authUrl,
                    '_blank',
                    'location=no,toolbar=yes,toolbarcolor=#FF6B35,closebuttoncolor=#FFFFFF,zoom=no,clearcache=yes,clearsessioncache=no,hardwareback=yes'
                );
                
                console.log('✅ In-app browser opened');
                
                // Listen for page load
                inAppBrowserRef.addEventListener('loadstart', (event) => {
                    console.log('📄 Loading:', event.url);
                });
                
                inAppBrowserRef.addEventListener('loadstop', (event) => {
                    console.log('✅ Loaded:', event.url);
                    
                    // Inject script to check authentication status
                    inAppBrowserRef.executeScript({
                        code: `
                            try {
                                // Check if user is logged in
                                const hasAuth = localStorage.getItem('user') || 
                                               localStorage.getItem('token') ||
                                               localStorage.getItem('firebase:authUser') ||
                                               sessionStorage.getItem('user');
                                               
                                if (hasAuth) {
                                    console.log('User authenticated!');
                                }
                            } catch(e) {
                                console.error('Auth check failed:', e);
                            }
                        `
                    });
                });
                
                // Listen for browser close
                inAppBrowserRef.addEventListener('exit', () => {
                    console.log('� In-app browser closed');
                    console.log('Reloading main window to sync authentication...');
                    
                    // Reload main window to pick up authentication
                    setTimeout(() => {
                        window.location.reload();
                    }, 500);
                });
                
                // Listen for errors
                inAppBrowserRef.addEventListener('loaderror', (event) => {
                    console.error('❌ Load error:', event);
                });
                
            } catch (error) {
                console.error('❌ Error opening in-app browser:', error);
                alert('బ్రౌజర్ ఓపెన్ చేయలేకపోయింది\nCould not open browser');
            }
        };
        
        // Add floating login button
        function addAuthButton() {
            if (!document.body) {
                setTimeout(addAuthButton, 100);
                return;
            }
            
            // Remove existing button
            const existing = document.getElementById('suchi-inapp-auth-btn');
            if (existing) existing.remove();
            
            // Create floating button
            const button = document.createElement('button');
            button.id = 'suchi-inapp-auth-btn';
            button.innerHTML = `
                <div style="font-size: 24px; margin-bottom: 5px;">🔐</div>
                <div style="font-size: 16px; font-weight: bold;">లాగిన్</div>
                <div style="font-size: 12px; opacity: 0.9;">Login</div>
            `;
            
            button.style.cssText = `
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 999999;
                background: linear-gradient(135deg, #FF6B35 0%, #E55A25 100%);
                color: white;
                border: none;
                padding: 15px 20px;
                border-radius: 20px;
                box-shadow: 0 8px 25px rgba(255, 107, 53, 0.5);
                cursor: pointer;
                font-family: Arial, sans-serif;
                text-align: center;
                min-width: 100px;
                transition: all 0.3s ease;
            `;
            
            // Add hover effect
            button.onmouseover = () => {
                button.style.transform = 'scale(1.1)';
                button.style.boxShadow = '0 10px 30px rgba(255, 107, 53, 0.7)';
            };
            
            button.onmouseout = () => {
                button.style.transform = 'scale(1)';
                button.style.boxShadow = '0 8px 25px rgba(255, 107, 53, 0.5)';
            };
            
            button.onclick = () => {
                console.log('🚀 Login button clicked');
                window.openAuthInAppBrowser();
            };
            
            document.body.appendChild(button);
            console.log('✅ Floating login button added');
            
            // Auto-hide if user seems logged in
            setTimeout(() => {
                // Check for login indicators
                if (localStorage.getItem('user') || 
                    localStorage.getItem('token') ||
                    localStorage.getItem('firebase:authUser') ||
                    document.querySelector('[data-logged-in]') ||
                    document.querySelector('.user-profile') ||
                    document.querySelector('.logout')) {
                    button.style.display = 'none';
                    console.log('ℹ️ User appears logged in, hiding button');
                }
            }, 3000);
        }
        
        // Add button when ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', addAuthButton);
        } else {
            addAuthButton();
        }
        
        // Watch for page changes
        let lastUrl = location.href;
        new MutationObserver(() => {
            const url = location.href;
            if (url !== lastUrl) {
                lastUrl = url;
                console.log('📍 URL changed:', url);
                // Re-check auth status
                setTimeout(addAuthButton, 1000);
            }
        }).observe(document, {subtree: true, childList: true});
        
        console.log('✅ In-App Browser authentication configured');
        console.log('   📱 Click floating button to login');
        console.log('   🔄 Cookies will sync automatically');
        
    } else {
        console.warn('⚠️ InAppBrowser plugin not available');
        console.log('Waiting for Cordova...');
        
        // Wait for Cordova to be ready
        document.addEventListener('deviceready', () => {
            console.log('✅ Cordova ready, retrying...');
            setTimeout(() => {
                window.location.reload();
            }, 100);
        }, false);
    }
    
})();




