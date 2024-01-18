import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class TextFieldBasic extends StatefulWidget {
  const TextFieldBasic({
    super.key,
    required this.controller,
    required this.isDarkMode,
    required this.hintText,
    this.onTap,
    this.isReadOnly,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    //required this.errorText,
  });

  final TextEditingController controller;
  final bool isDarkMode;
  final String hintText;
  final bool? isReadOnly;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  //final String errorText;
  final TextInputType? keyboardType;

  @override
  State<TextFieldBasic> createState() => _TextFieldBasicState();
}

class _TextFieldBasicState extends State<TextFieldBasic> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //inputFormatters: [ThousandsFormatter()],
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.isReadOnly ?? false,
      style: TextStyle(
        fontFamily: fontApp,
      ),
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
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorProject.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.hintText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: fontApp,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: fontApp,
        ),
        errorStyle: TextStyle(fontFamily: fontApp),
        //errorText: widget.errorText,
      ),
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      validator: widget.validator,
      enabled: widget.enabled,
    );
  }
}
