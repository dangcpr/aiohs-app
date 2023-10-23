import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CleaningHourlyStep3Screen extends StatefulWidget {
  const CleaningHourlyStep3Screen({super.key});

  @override
  State<CleaningHourlyStep3Screen> createState() => _CleaningHourlyStep3ScreenState();
}

class _CleaningHourlyStep3ScreenState extends State<CleaningHourlyStep3Screen> {
  
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Xác nhận và thanh toán',
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Text("Xác nhận và thanh toán"),
    );
  }
}