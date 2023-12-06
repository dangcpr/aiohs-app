import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  Future<GoogleSignInAccount?> handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      debugPrint(account!.email);
      return account;
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> handleSignOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ]
    );
    try {
      await googleSignIn.signOut();
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }
}