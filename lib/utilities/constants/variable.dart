import 'package:flutter/material.dart';

const nameApp = "AIO Home Serives";
const debugServer = "http://192.168.72.128:9000";

const nameAppShort = "AIOHS";

const fontApp = "GoogleSans-Regular";
const fontBoldApp = "GoogleSans-Bold";
const maps_api_key = "AIzaSyAq0YUCj0v0pFl9wGuZOiyIDm9Db8fGFPA";

const supportLanguage = [
  Locale('vi', 'VN'),
  Locale('en', 'US'),
];

class colorProject {
  static const Color primaryColor = Color(0xFF00B27D);
  static const Color subColor = Color(0xFF696969);
  static const Color smallTitle = Colors.black;
  static const Color primaryColorLight = Color.fromARGB(255, 0, 223, 156);
  static const Color secondaryColorLight = Color.fromARGB(255, 78, 252, 255);
}

class fontSize {
  static const double large = 24;
  static const double mediumLarger = 17;
  static const double medium = 15;
  static const double textField = 13;
}

class padding {
  static const paddingSmall = 8.0;
  static const paddingMedium = 16.0;
  static const paddingLarge = 24.0;
}

class dialog {
  static const networkError = "Unable to connect, please check your network";
  static const sentOTP = "OTP code is sent";
  static const wrongOTP = "OTP code incorrect";
  static const emailExist = "Email already exist";
  static const emailWrong = "Please check your email";
  static const sthWrong = "Your email or password is incorrect";
}

class textStyle {
  static TextStyle normalStyle({double fontSize = 14}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontApp,
    );
  }

  static TextStyle headerStyle({double fontSize = 24}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: fontBoldApp,
      fontWeight: FontWeight.bold,
    );
  }
}

class sizedBox {
  static SizedBox largeHeight() {
    return const SizedBox(
      height: 20,
    );
  }

  static SizedBox mediumHeight() {
    return const SizedBox(
      height: 15,
    );
  }

  static SizedBox smallHeight() {
    return const SizedBox(
      width: 10,
    );
  }

  static SizedBox largeWidth() {
    return const SizedBox(
      width: 15,
    );
  }

  static SizedBox mediumWidth() {
    return const SizedBox(
      width: 12,
    );
  }

  static SizedBox smallWidth() {
    return const SizedBox(
      width: 8,
    );
  }
}
