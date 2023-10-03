import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ButtonGreenApp extends StatefulWidget {
  const ButtonGreenApp(
      {super.key, required this.label, required this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  State<ButtonGreenApp> createState() => _ButtonGreenAppState();
}

class _ButtonGreenAppState extends State<ButtonGreenApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colorProject.primaryColor.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          backgroundColor: colorProject.primaryColor,
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: fontBoldApp,
          ),
        ),
      ),
    );
  }
}
