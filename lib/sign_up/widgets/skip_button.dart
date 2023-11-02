import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/views/login_screen.dart';
import 'package:rmservice/sign_up/views/signup_screen.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class SkipButton extends StatefulWidget {
  const SkipButton({super.key});

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: SignupScreen(first_time: false),
            childCurrent: LoginScreen(first_time: false),
          ),
        );
      },
      child: Text(
        "SKIP",
        style: TextStyle(
          color: colorProject.primaryColor,
        ),
      ),
    );
  }
}
