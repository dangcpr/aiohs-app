import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CleaningLongTermStep2 extends StatefulWidget {
  const CleaningLongTermStep2({super.key});

  @override
  State<CleaningLongTermStep2> createState() => _CleaningLongTermStep2State();
}

class _CleaningLongTermStep2State extends State<CleaningLongTermStep2> {
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
