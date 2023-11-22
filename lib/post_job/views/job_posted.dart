import 'package:flutter/material.dart';

class JobPosted extends StatefulWidget {
  const JobPosted({super.key});

  @override
  State<JobPosted> createState() => _JobPostedState();
}

class _JobPostedState extends State<JobPosted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Job Posted")),
    );
  }
}