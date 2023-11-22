import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class TextSubLabel extends StatefulWidget {
  const TextSubLabel(
      {super.key, required this.label, required this.isDarkMode, this.color});

  final String label;
  final bool isDarkMode;
  final Color? color;

  @override
  State<TextSubLabel> createState() => TextSubLabelState();
}

class TextSubLabelState extends State<TextSubLabel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      style: TextStyle(
        color: widget.color == null
            ? (widget.isDarkMode ? Colors.white : Colors.black)
            : widget.color,
        fontFamily: fontApp,
        fontSize: fontSize.medium,
      ),
    );
  }
}
