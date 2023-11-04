import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShoppingStep3Method2Screen extends StatefulWidget {
  const ShoppingStep3Method2Screen({super.key});

  @override
  State<ShoppingStep3Method2Screen> createState() =>
      _ShoppingStep3Method2ScreenState();
}

class _ShoppingStep3Method2ScreenState
    extends State<ShoppingStep3Method2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Danh sách cần mua",
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: Center(
        child: Text("Method 2"),
      ),
    );
  }
}
