import 'package:flutter/material.dart';

class WorkerOrderAccepted extends StatefulWidget {
  const WorkerOrderAccepted({super.key});

  @override
  State<WorkerOrderAccepted> createState() => _WorkerOrderAcceptedState();
}

class _WorkerOrderAcceptedState extends State<WorkerOrderAccepted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Accepted'),
    );
  }
}