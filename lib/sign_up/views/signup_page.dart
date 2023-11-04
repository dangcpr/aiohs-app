import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/sign_up/cubits/signup_cubit.dart';
import 'package:rmservice/sign_up/views/signup_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.first_time});

  final bool first_time;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: SignupScreen(first_time: widget.first_time),
    );
  }
}
