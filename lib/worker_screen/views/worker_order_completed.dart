import 'package:flutter/material.dart';

class WorkerOrderCompleted extends StatefulWidget {
  const WorkerOrderCompleted({super.key});

  @override
  State<WorkerOrderCompleted> createState() => _WorkerOrderCompletedState();
}

class _WorkerOrderCompletedState extends State<WorkerOrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Completed'),
    );
  }
}