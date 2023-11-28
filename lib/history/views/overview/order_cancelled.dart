import 'package:flutter/material.dart';

class HistoryOrderCancelled extends StatefulWidget {
  const HistoryOrderCancelled({super.key});

  @override
  State<HistoryOrderCancelled> createState() => _HistoryOrderCancelledState();
}

class _HistoryOrderCancelledState extends State<HistoryOrderCancelled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Order Cancelled'),
      )
    );
  }
}