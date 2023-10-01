import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xFF00B27D),
  useMaterial3: true,
  brightness: Brightness.dark,
    textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: colorProject.primaryColor,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(fontFamily: 'GoogleSans-Bold', fontSize: fontSize.large),
    labelMedium: TextStyle(fontFamily: 'GoogleSans-Regular', fontSize: fontSize.medium),
  ),
);
