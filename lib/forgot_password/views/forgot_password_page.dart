import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import 'forgot_password_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Quên mật khẩu',
          style: textStyle.headerStyle(fontSize: 18),
        ),
      ),
      body: ForgotPasswordScreen(),
    );
  }
}
