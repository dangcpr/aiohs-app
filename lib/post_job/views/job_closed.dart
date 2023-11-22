import 'package:flutter/material.dart';

class JobClosed extends StatefulWidget {
  const JobClosed({super.key});

  @override
  State<JobClosed> createState() => _JobClosedState();
}

class _JobClosedState extends State<JobClosed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Job Closed")),
    );
  }
}