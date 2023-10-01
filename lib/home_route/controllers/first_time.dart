// Kiểm tra xem có phải user lần đầu bấm vào app không
import 'package:flutter/foundation.dart';
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
}
