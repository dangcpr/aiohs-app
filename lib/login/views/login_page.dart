import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/login_cubit.dart';
import 'package:rmservice/login/views/login_screen.dart';

import '../../authentication_repository/authentication_repository.dart';

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
