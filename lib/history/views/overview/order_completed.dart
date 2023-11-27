import 'package:flutter/material.dart';

class HistoryOrderCompleted extends StatefulWidget {
  const HistoryOrderCompleted({super.key});

  @override
  State<HistoryOrderCompleted> createState() => _HistoryOrderCompletedState();
}

class _HistoryOrderCompletedState extends State<HistoryOrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Order Completed'),
      )
    );
  }
}