import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class TextFieldBasic extends StatefulWidget {
  const TextFieldBasic(
      {super.key,
      required this.controller,
      required this.isDarkMode,
      required this.hintText,
      this.onChanged,
      this.validator});

  final TextEditingController controller;
  final bool isDarkMode;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<TextFieldBasic> createState() => _TextFieldBasicState();
}

class _TextFieldBasicState extends State<TextFieldBasic> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //inputFormatters: [ThousandsFormatter()],
      //keyboardType: TextInputType.number,
      controller: widget.controller,
      style: TextStyle(
        fontFamily: fontApp,
      ),
      textAlignVertical: TextAlignVertical.top,
      maxLines: null,
      expands: true,
      cursorColor: colorProject.primaryColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isDarkMode ? Colors.white : Colors.black,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorProject.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
