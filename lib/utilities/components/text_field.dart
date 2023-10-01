import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

// ignore: must_be_immutable
class TextFieldApp extends StatefulWidget {
  TextFieldApp({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    this.obsecure = false,
    this.validatorFunc,
    this.errorText,
    required this.darkMode,
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  bool obsecure;
  String? Function(String?)? validatorFunc;
  String? errorText;
  bool darkMode;

  @override
  State<TextFieldApp> createState() => _TextFieldAppState();
}

class _TextFieldAppState extends State<TextFieldApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colorProject.primaryColor.withOpacity(0.07),
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextFormField(
        style: TextStyle(
          fontFamily: fontApp,
        ),
        controller: widget.controller,
        obscureText: widget.obsecure,
        cursorColor: colorProject.primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.darkMode == true ? Colors.transparent : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hoverColor: colorProject.primaryColor,
          prefixIcon: Icon(widget.icon, color: colorProject.primaryColor),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: colorProject.primaryColor,
            fontFamily: fontApp,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorProject.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          errorText: widget.errorText,
          errorStyle: TextStyle(
            fontFamily: fontApp,
          )
        ),
        validator: widget.validatorFunc,
        
      ),
    );
  }
}
