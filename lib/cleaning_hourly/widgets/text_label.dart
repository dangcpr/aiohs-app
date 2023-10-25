import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class TextLabel extends StatefulWidget {
  const TextLabel({super.key, required this.label, required this.isDarkMode});

  final String label;
  final bool isDarkMode;

  @override
  State<TextLabel> createState() => _TextLabelState();
}

class _TextLabelState extends State<TextLabel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label,
      style: TextStyle(
        color: widget.isDarkMode ? Colors.white : Colors.black,
        fontFamily: fontBoldApp,
        fontSize: fontSize.mediumLarger,
      ),
    );
  }
}
