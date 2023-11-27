import 'package:flutter/material.dart';

class HistoryOrderReceived extends StatefulWidget {
  const HistoryOrderReceived({super.key});

  @override
  State<HistoryOrderReceived> createState() => _HistoryOrderReceivedState();
}

class _HistoryOrderReceivedState extends State<HistoryOrderReceived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Order Received'),
      )
    );
  }
}