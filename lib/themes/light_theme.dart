import 'package:flutter/material.dart';
import 'package:rmservice/constants/variable.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF00B27D),
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: TextTheme(
    titleLarge: TextStyle(
        fontFamily: 'GoogleSans-Bold',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colorProject.primaryColor),
    labelMedium: TextStyle(
        fontFamily: 'GoogleSans-Regular',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: colorProject.subColor),
    titleSmall: TextStyle(
        fontFamily: 'GoogleSans-Regular',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: colorProject.smallTitle),
  ),
);
