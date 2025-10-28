package com.suchi.app;

import android.content.Context;
import android.content.Intent;
import android.webkit.JavascriptInterface;
import android.widget.Toast;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;

public class WebAppInterface {
    Context mContext;
    GoogleSignInClient googleSignInClient;

    WebAppInterface(Context c) {
        mContext = c;
        setupGoogleSignIn();
    }

    private void setupGoogleSignIn() {
        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestEmail()
                .build();
        
        googleSignInClient = GoogleSignIn.getClient(mContext, gso);
    }

    @JavascriptInterface
    public void showToast(String toast) {
        Toast.makeText(mContext, toast, Toast.LENGTH_SHORT).show();
    }

    @JavascriptInterface
    public void signInWithGoogle() {
        Intent signInIntent = googleSignInClient.getSignInIntent();
        ((MainActivity) mContext).startActivityForResult(signInIntent, 9001);
    }

    @JavascriptInterface
    public void signOut() {
        googleSignInClient.signOut();
    }

    @JavascriptInterface
    public String getDeviceInfo() {
        return android.os.Build.MODEL + " " + android.os.Build.VERSION.RELEASE;
    }
}