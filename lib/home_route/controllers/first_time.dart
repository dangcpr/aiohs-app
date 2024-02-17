// Kiểm tra xem có phải user lần đầu bấm vào app không
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeController {
  Future<void> setFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('firstTime', false);
      debugPrint('Thành công Set');
    } catch (e) {
      debugPrint(e.toString());

      throw 'Something went wrong';
    }
  }

  Future<bool> getFirstTime() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //await prefs.remove('firstTime');
      debugPrint('Thành công Get');

      return prefs.getBool('firstTime') ?? true;
    } catch (e) {
      debugPrint(e.toString());

      throw 'Something went wrong';
    }
  }

  Future<void> setRemoteConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      //await remoteConfig.fetchAndActivate();
      hasOauth_G = remoteConfig.getBool('oauth_G');
      hasOauth_F = remoteConfig.getBool('oauth_F');
      hasOauth_A = remoteConfig.getBool('oauth_A');
      extractIDAuthorization = remoteConfig.getString('extractIDAuthorization');
      extractIDTokenID = remoteConfig.getString('extractIDTokenID');
      extractIDTokenKey = remoteConfig.getString('extractIDTokenKey');
      debugPrint(hasOauth_G.toString());
      debugPrint(hasOauth_F.toString());
      debugPrint(hasOauth_A.toString());
      debugPrint(extractIDAuthorization);
      debugPrint(extractIDTokenID);
      debugPrint(extractIDTokenKey);
      remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.activate();

        hasOauth_G = remoteConfig.getBool('oauth_G');
        hasOauth_F = remoteConfig.getBool('oauth_F');
        hasOauth_A = remoteConfig.getBool('oauth_A');

        extractIDAuthorization = remoteConfig.getString('extractIDAuthorization');
        extractIDTokenID = remoteConfig.getString('extractIDTokenID');
        extractIDTokenKey = remoteConfig.getString('extractIDTokenKey');
      });
    } catch (e) {
      debugPrint(e.toString());

      throw 'Something went wrong';
    }
  }

}
