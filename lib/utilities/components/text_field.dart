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
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  bool obsecure;
  String Function(String?)? validatorFunc;

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
            color: Color.fromARGB(16, 0, 0, 0),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obsecure,
        cursorColor: colorProject.primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          hoverColor: colorProject.primaryColor,
          prefixIcon: Icon(widget.icon, color: colorProject.primaryColor),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: colorProject.primaryColor,
            fontFamily: 'GoogleSans-Regular',
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        validator: widget.validatorFunc,
      ),
    );
  }
}
