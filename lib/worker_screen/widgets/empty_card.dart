import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class WorkerEmptyOrder extends StatefulWidget {
  const WorkerEmptyOrder({super.key});

  @override
  State<WorkerEmptyOrder> createState() => _WorkerEmptyOrderState();
}

class _WorkerEmptyOrderState extends State<WorkerEmptyOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'assets/images/Empty-bro.png',
          ),
          Text(
            "Không có đơn",
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.large,
              color: colorProject.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Không tồn tại đơn",
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