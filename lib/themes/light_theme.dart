import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF00B27D),
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: TextTheme(
    titleLarge: TextStyle(fontFamily: 'GoogleSans-Bold', fontSize: 24),
    labelMedium: TextStyle(fontFamily: 'GoogleSans-Regular', fontSize: 14),
  ),
);
