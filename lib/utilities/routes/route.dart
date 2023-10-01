import 'package:flutter/material.dart';
import 'package:rmservice/home_route/views/intro_screen/intro_screen.dart';
import 'package:rmservice/login/views/login_screen.dart';
import 'package:rmservice/sign_up/views/signup_screen.dart';
class Routes {
  static const String loginScreen = 'login';
  static const String signupScreen = 'signup';
  static const String introScreen = 'intro';
  static const String splashScreen = 'splash';

  static Route<dynamic> controller(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case loginScreen:
      bool argument = args as bool;
      return MaterialPageRoute(
        builder: (context) => LoginScreen(
          first_time: argument,
        ),
      );

    case signupScreen:
      bool argument = args as bool;
      return MaterialPageRoute(
        builder: (context) => SignupScreen(
          first_time: argument,
        ),
      );

    case introScreen:
      return MaterialPageRoute(
        builder: (context) => IntroScreenApp(),
      );
    default:
      bool argument = args as bool;
      AlertDialog(
        title: Text('Error'),
        content: Text('No route defined for ${settings.name}'),
      );
      return MaterialPageRoute(
        builder: (context) => LoginScreen(
          first_time: argument,
        ),
      );
  }
}
}

