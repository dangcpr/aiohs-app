import 'package:flutter/material.dart';

class WorkerOrderCancelled extends StatefulWidget {
  const WorkerOrderCancelled({super.key});

  @override
  State<WorkerOrderCancelled> createState() => _WorkerOrderCancelledState();
}

class _WorkerOrderCancelledState extends State<WorkerOrderCancelled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Cancelled'),
    );
  }
}