import 'package:flutter/material.dart';

class JobActiving extends StatefulWidget {
  const JobActiving({super.key});

  @override
  State<JobActiving> createState() => _JobActivingState();
}

class _JobActivingState extends State<JobActiving> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Job Activing")),
    );
  }
}