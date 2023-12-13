import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';

const nameApp = "AIO Home Serives";
const debugServer = "http://192.168.72.128:9000";
const extractIDServer = "https://api.idg.vnpt.vn";
const extractIDTokenKey = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAJyeol5Yc2x0bDbmcuDcqKGfiMMjb/e4awSwQF92wBKon8CXvvuMntUCfeAZsm3VISNWOgejojKjDKZj1baQjPECAwEAAQ==";
const extractIDTokenID = "0c54369a-0a61-750b-e063-63199f0a3881";
const extractIDAuthorization = "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIwYzU0MmRlOS1kMmY5LTUzOTgtZTA2My02MzE5OWYwYThjYzciLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoiZGFuZ2NwckBvdXRsb29rLmNvbSIsInNjb3BlIjpbInJlYWQiXSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3QiLCJuYW1lIjoiZGFuZ2NwckBvdXRsb29rLmNvbSIsInV1aWRfYWNjb3VudCI6IjBjNTQyZGU5LWQyZjktNTM5OC1lMDYzLTYzMTk5ZjBhOGNjNyIsImF1dGhvcml0aWVzIjpbIlVTRVIiXSwianRpIjoiOGQwNDE3Y2ItMzU0Mi00YzdjLWE5OWEtZmEzODYxNmQ1OWYxIiwiY2xpZW50X2lkIjoiYWRtaW5hcHAifQ.2xiYu3pvmGdY7NnKHNvxALVEK7BrIlOVx4K0YXNUTHEaAa1DJ0RwY8PtafNFcpOrmaE8rp8joP6LU11OoFKOyYk-pIYUZgtSeWYz0PxE33NJMP9THANjPTu1NdAlh2Lef-Qhu4Np58EoAiYppva7BX6vbbu5J65CeAj1FkYbtwG3Oi3YJ5mj8H0nWlny1V0oT8gozQwAZeCEMO8duUEW03vlMj5PqW3_KiSGWdY29zJ0MMo9aPVAu3Sm038ftCZaSHByT_tHfrGZBRPUzfnO-r7DBkk8d05aDSRme0e_w5zeoxVSA6GVd5a0ZQtl51c-tLK0WhxtS0Wi3SiinbIxmg";
final cloudinary = Cloudinary.signedConfig(
  cloudName: "aiohs",
  apiKey: "148632498765894",
  apiSecret: "r813jppTpHitSkg3kCdCQ_nEQFE",
);

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
