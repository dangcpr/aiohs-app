import 'package:flutter/material.dart';

class SplashScreenApp extends StatefulWidget {
  const SplashScreenApp({super.key});

  @override
  State<SplashScreenApp> createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      )
    );
  }
}