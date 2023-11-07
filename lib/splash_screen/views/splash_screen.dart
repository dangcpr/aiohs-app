import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/home_route/views/home_screen.dart';
import 'package:rmservice/notification/controllers/fcm.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
        NotificationController().init();
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 150,
        width: 150,
        child: Image.asset("assets/images/logo.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const IntroScreen(),
    );
  }
}
