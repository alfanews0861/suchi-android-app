// Native Google Sign-In Bridge
// Uses @codetrix-studio/capacitor-google-auth plugin

console.log('🔐 Native Google Auth Bridge Loading...');

// Wait for Capacitor to be ready
document.addEventListener('DOMContentLoaded', async function() {
    console.log('✅ DOM Ready - Setting up Native Google Auth');
    
    // Check if plugin is available
    if (typeof Capacitor !== 'undefined' && Capacitor.Plugins && Capacitor.Plugins.GoogleAuth) {
        console.log('✅ Native Google Auth plugin available');
        
        // Initialize plugin
        try {
            await Capacitor.Plugins.GoogleAuth.initialize();
            console.log('✅ Google Auth initialized');
        } catch (error) {
            console.error('❌ Failed to initialize Google Auth:', error);
        }
        
        // Create global function for website to call
        window.nativeGoogleSignIn = async function() {
            console.log('🚀 Native Google Sign-In triggered');
            
            try {
                const result = await Capacitor.Plugins.GoogleAuth.signIn();
                console.log('✅ Sign-In successful:', result);
                
                // Return user info to website
                return {
                    success: true,
                    user: result.authentication,
                    idToken: result.authentication.idToken,
                    email: result.email,
                    name: result.name,
                    imageUrl: result.imageUrl
                };
                
            } catch (error) {
                console.error('❌ Sign-In failed:', error);
                return {
                    success: false,
                    error: error.message
                };
            }
        };
        
        // Create sign-out function
        window.nativeGoogleSignOut = async function() {
            console.log('👋 Native Google Sign-Out triggered');
            
            try {
                await Capacitor.Plugins.GoogleAuth.signOut();
                console.log('✅ Sign-Out successful');
                return { success: true };
            } catch (error) {
                console.error('❌ Sign-Out failed:', error);
                return { success: false, error: error.message };
            }
        };
        
        console.log('✅ Native Google Auth functions registered');
        console.log('   - window.nativeGoogleSignIn()');
        console.log('   - window.nativeGoogleSignOut()');
        
    } else {
        console.warn('⚠️ Native Google Auth plugin NOT available');
        console.warn('   Falling back to web-based auth');
    }
});
