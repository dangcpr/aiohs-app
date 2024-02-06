import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

void showCircleIndicatorDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const PopScope(
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(
            color: colorProject.primaryColor,
          ),
        ),
      );
    },
  );
}
