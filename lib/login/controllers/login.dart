import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> handleSignOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);
    try {
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String> handleFacebookSignIn() async {
    try {
      final fb = FacebookLogin();

// Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

// Check result status
      switch (res.status) {
        case FacebookLoginStatus.success:
          // Logged in

          // Send access token to server for validation and auth
          final FacebookAccessToken accessToken = res.accessToken!;
          print('Access token: ${accessToken.token}');

          // Get profile data
          final profile = await fb.getUserProfile();
          print('Hello, ${profile!.name}! You ID: ${profile!.userId}');

          // Get user profile image url
          final imageUrl = await fb.getProfileImageUrl(width: 100);
          print('Your profile image: $imageUrl');

          // Get email (since we request email permission)
          final email = await fb.getUserEmail();
          // But user can decline permission
          if (email != null) {
            print('And your email is $email');
            return email;
          } else {
            throw 'And your email is null';
          }

          //break;
        case FacebookLoginStatus.cancel:
          // User cancel log in
          throw 'User cancel log in';
        //break;
        case FacebookLoginStatus.error:
          // Log in failed
          print('Error while log in: ${res.error}');
          throw 'User cancel log in';
          //break;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> handleSignOutFacebook() async {
    await FacebookLogin().logOut();
    debugPrint('Sign out success');
  }
}
