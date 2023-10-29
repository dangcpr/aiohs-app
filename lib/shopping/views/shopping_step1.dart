import 'package:flutter/material.dart';

class ShoppingStep1Screen extends StatefulWidget {
  const ShoppingStep1Screen({super.key});

  @override
  State<ShoppingStep1Screen> createState() => _ShoppingStep1ScreenState();
}

class _ShoppingStep1ScreenState extends State<ShoppingStep1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Đây là màn hình Shopping"),
      ),
    );
  }
}
