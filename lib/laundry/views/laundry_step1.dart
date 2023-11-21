import 'package:flutter/material.dart';

class LaundryStep1Screen extends StatefulWidget {
  const LaundryStep1Screen({super.key});

  @override
  State<LaundryStep1Screen> createState() => _LaundryStep1ScreenState();
}

class _LaundryStep1ScreenState extends State<LaundryStep1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("Laundry"),
    );
  }
}
