import 'package:flutter/material.dart';

class CompleteShoppingScreen extends StatefulWidget {
  const CompleteShoppingScreen({super.key});

  @override
  State<CompleteShoppingScreen> createState() => _CompleteShoppingScreenState();
}

class _CompleteShoppingScreenState extends State<CompleteShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hoàn thành")
      )
    );
  }
}