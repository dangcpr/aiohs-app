import 'package:flutter/material.dart';

class CircleIndicatorScreen extends StatefulWidget {
  const CircleIndicatorScreen({super.key});

  @override
  State<CircleIndicatorScreen> createState() => _CircleIndicatorScreenState();
}

class _CircleIndicatorScreenState extends State<CircleIndicatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Color(0xFF00B27D)
      ),
    );
  }
}