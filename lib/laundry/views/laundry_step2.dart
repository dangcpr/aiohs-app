import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class LaundryStep2Screen extends StatefulWidget {
  const LaundryStep2Screen({super.key});

  @override
  State<LaundryStep2Screen> createState() => _LaundryStep2ScreenState();
}

class _LaundryStep2ScreenState extends State<LaundryStep2Screen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Chọn thời gian giao và nhận đồ",
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}