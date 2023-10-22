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
      return await googleSignIn.signIn();
    } catch(e) {
      debugPrint(e.toString());
      return null;
    }
  }
}