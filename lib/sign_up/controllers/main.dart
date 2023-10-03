import 'package:flutter/material.dart';
import 'package:rmservice/sign_up/models/user.dart';

class SignupController {
  Future<void> signup(UserSignup user) async {
    try {
      //delay 3s
      debugPrint("Chào");
      await Future.delayed(const Duration(seconds: 3));
      debugPrint("Thành công");
    } catch (e) {
      debugPrint("Lỗi hệ thống");
      throw "Lỗi hệ thống";
    }
  }
}