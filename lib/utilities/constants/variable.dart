import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';

String fcmToken = "";
const nameApp = "AIO Home Serives";
const debugServer = "http://192.168.206.129:9000";
// const debugServer = "https://9e96-171-231-25-147.ngrok-free.app";
const serverChat = "192.168.206.129:8080"; //not include method http or https
// const serverChat = "a126-171-231-25-147.ngrok-free.app"; //not include method http or https
// const debugServer = "https://d7f0-171-231-61-254.ngrok-free.app/";
const extractIDServer = "https://api.idg.vnpt.vn";
const extractIDTokenKey =
    "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAK8beog2hh8thfXlbs/L7483K2EIEgTbxmfsCT2YWG3mAJCxIu4YReCUJ3VWZwqcgLPgLNTqmz6LhM4phSc69OUCAwEAAQ==";
const extractIDTokenID = "0ee76858-d9ea-6ec0-e063-62199f0aee0c";
const extractIDAuthorization =
    "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyNmQzMWNmYi1iMmQyLTExZWUtYWU4Zi0wOThkYTc0NTk1YjMiLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoiaGFpZGFuZ2NodXByb25nQGdtYWlsLmNvbSIsInNjb3BlIjpbInJlYWQiXSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3QiLCJuYW1lIjoiaGFpZGFuZ2NodXByb25nQGdtYWlsLmNvbSIsImV4cCI6MTcwNzgyNDY0NiwidXVpZF9hY2NvdW50IjoiMjZkMzFjZmItYjJkMi0xMWVlLWFlOGYtMDk4ZGE3NDU5NWIzIiwiYXV0aG9yaXRpZXMiOlsiVVNFUiJdLCJqdGkiOiJiZWVlMThhOC00MWQ0LTRjNGMtYTFiMy05OGJlZmEwYmViNGIiLCJjbGllbnRfaWQiOiJjbGllbnRhcHAifQ.RsE_lMRmpCTvek12F-lvixI-u-BSDCXizfPt3A6C9zCTxGnW1EXNvtmd4hiTeObcu8BIHc8LsVpmjNGvyuOyBTvawf3zAoEFKBCZ6RQ4pJxgeLLsGDkLBmbgZf4iSGKO3rj8rOilRddnHUGuGDpxJeEFGTOWv5vZmuavgQ3zaJg08cGZtSPINOBwxc5ZgS4MYCzwLn1XCc_DNPRXLJK6QP3Q_L9KIZUTvjkmRGNhcsCJxcgFX6UDAaxl04SN7alCe4kNJU-prKyvXTcEZ6IBlUzCJ6OHIIZ4tn8mXP_Qkxzedw8TvXWe9x85zhUY0YwwQXHgfcSlhqdkxBY516G78Q";
final cloudinary = Cloudinary.signedConfig(
  cloudName: "aiohs",
  apiKey: "148632498765894",
  apiSecret: "r813jppTpHitSkg3kCdCQ_nEQFE",
);
bool hasOauth_G = false;
bool hasOauth_F = false;

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
