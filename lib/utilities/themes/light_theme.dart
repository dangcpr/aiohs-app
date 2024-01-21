import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xFF00B27D),
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'GoogleSans-Regular',
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: colorProject.primaryColor,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'GoogleSans-Bold',
      fontSize: fontSize.large,
      fontWeight: FontWeight.w700,
      color: colorProject.primaryColor,
    ),
    labelMedium: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: fontSize.medium,
      fontWeight: FontWeight.w400,
      color: colorProject.subColor,
    ),
    titleSmall: TextStyle(
      fontFamily: 'GoogleSans-Regular',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: colorProject.smallTitle,
    ),
  ),
);
