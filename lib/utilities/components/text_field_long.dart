import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class TextFieldLong extends StatefulWidget {
  const TextFieldLong({
    super.key,
    required this.height,
    required this.controller,
    required this.isDarkMode,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    //required this.errorText,
  });

  final double height;
  final TextEditingController controller;
  final bool isDarkMode;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  //final String errorText;

  @override
  State<TextFieldLong> createState() => _TextFieldLongState();
}

class _TextFieldLongState extends State<TextFieldLong> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        //inputFormatters: [ThousandsFormatter()],
        //keyboardType: TextInputType.number,
        minLines: 3,
        maxLines: 3,
        controller: widget.controller,
        style: TextStyle(
          fontFamily: fontApp,
        ),
        cursorColor: colorProject.primaryColor,
        decoration: InputDecoration(
          isDense: true,
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
        validator: widget.validator,
        enabled: widget.enabled,
      ),
    );
  }
}
