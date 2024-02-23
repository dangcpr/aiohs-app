import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';

String fcmToken = "";
const nameApp = "AIO Home Serives";
const protocolServer = "http://";
const debugServer = protocolServer + "192.168.220.131:9000";
// const debugServer = protocolServer + "13.213.83.249:9000";
// const debugServer = protocolServer + "18.143.167.78:9000";

// const debugServer = "https://9e96-171-231-25-147.ngrok-free.app";
const protocolChat = "http://";
const serverChat = "13.213.83.249:8080"; //not include method http or https
// const serverChat = "a126-171-231-25-147.ngrok-free.app"; //not include method http or https
// const debugServer = "https://d7f0-171-231-61-254.ngrok-free.app/";
const extractIDServer = "https://api.idg.vnpt.vn";
String extractIDTokenKey =
    "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIHTGM6SfVzQwl1LHK0wydwNY5w/Yetu//Z50HXZlOG0cLveJz1k/l2hx6HpeJTdaMOhcBn/zGImbjYU7uzEcu8CAwEAAQ==";
String extractIDTokenID = "1198b420-da7b-201d-e063-63199f0a8fa9";
String extractIDAuthorization =
    "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMTk4YjE0Ny04OWVjLTMzNzMtZTA2My02MjE5OWYwYTgwMzciLCJhdWQiOlsicmVzdHNlcnZpY2UiXSwidXNlcl9uYW1lIjoiZGFuZ2NwckB5YW5kZXguY29tIiwic2NvcGUiOlsicmVhZCJdLCJpc3MiOiJodHRwczovL2xvY2FsaG9zdCIsIm5hbWUiOiJkYW5nY3ByQHlhbmRleC5jb20iLCJ1dWlkX2FjY291bnQiOiIxMTk4YjE0Ny04OWVjLTMzNzMtZTA2My02MjE5OWYwYTgwMzciLCJhdXRob3JpdGllcyI6WyJVU0VSIl0sImp0aSI6IjdkNjMyMzA3LTM3NDktNDg4Yi1hYzQzLTE5OWMwMjc2NzFkNSIsImNsaWVudF9pZCI6ImFkbWluYXBwIn0.VIvyjIB1e6kgP7u0-u_cacoCZieQj3nb6SzX5Uu07iK6v2sfLhdzr6MA96pCwfU17YXogc392k84Df7AQDI-5TMCKwZfrPL8fgiqZLK8uQb58M0AP4f_Lz4KLKmuVhmXtUXd7t1PceEdF6R-PcJEjRkoabl9WkFkTlq7RTP-HPmxADxpr-kNd7JdSkuFzoDBt6jL7uGSLOQGn1qTcGKutj35SkuzpSdv-DuTxy7bKEZ1XM81orpmvVeZiIqqRbdXJDePdfPYiKYO8nlBKLAlFv9odLvJ8ePYxfSG3ARHeNUZRCaFH_s7VaSdWP_nqOTrpe8joaW6Mlwdy6nWGMW03g";
final cloudinary = Cloudinary.signedConfig(
  cloudName: "aiohs",
  apiKey: "148632498765894",
  apiSecret: "r813jppTpHitSkg3kCdCQ_nEQFE",
);
bool hasOauth_G = false;
bool hasOauth_F = false;
bool hasOauth_A = false;

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
