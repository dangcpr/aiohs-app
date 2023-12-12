import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class WorkerEmptyOrder extends StatefulWidget {
  const WorkerEmptyOrder({super.key, required this.title, required this.desc});

  final String title;
  final String desc;

  @override
  State<WorkerEmptyOrder> createState() => _WorkerEmptyOrderState();
}

class _WorkerEmptyOrderState extends State<WorkerEmptyOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Image.asset(
            'assets/images/Empty-bro.png',
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.large,
              color: colorProject.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontApp,
              fontSize: fontSize.medium,
              color: colorProject.subColor,
            ),
          ),
        ],
      ),
    );
  }
}