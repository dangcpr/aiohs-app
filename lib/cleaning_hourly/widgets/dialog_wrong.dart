import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class DialogWrong extends StatefulWidget {
  const DialogWrong({super.key, required this.notification});

  final String notification;

  @override
  State<DialogWrong> createState() => _DialogWrongState();
}

class _DialogWrongState extends State<DialogWrong> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        Icons.cancel_outlined,
        color: Colors.red,
        size: 50,
      ),
      content: Text(
        textAlign: TextAlign.center,
        widget.notification,
        style: TextStyle(
          fontFamily: fontBoldApp,
          fontSize: fontSize.mediumLarger,
        ),
      ),
    );
  }
}
