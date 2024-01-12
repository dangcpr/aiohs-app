import 'package:flutter/material.dart';
import 'package:rmservice/login/views/login_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.first_time});

  final bool first_time;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginScreen(first_time: widget.first_time),
        ),
      
    );
  }
}
