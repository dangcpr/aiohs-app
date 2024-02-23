import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/views/worker_order_accepted.dart';
import 'package:rmservice/worker_screen/views/worker_order_all.dart';
import 'package:rmservice/worker_screen/views/worker_order_cancelled.dart';
import 'package:rmservice/worker_screen/views/worker_order_completed.dart';

class WorkerScreen extends StatefulWidget {
  const WorkerScreen({super.key});

  @override
  State<WorkerScreen> createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Gần đây', icon: Icon(Icons.location_on)),
    Tab(text: 'Đã nhận', icon: Icon(Icons.add_alert)),
    Tab(text: "Đã hoàn thành", icon: Icon(Icons.archive_outlined)),
    Tab(text: 'Đã hủy', icon: Icon(Icons.cancel)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Giúp việc",
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger,
            ),
          ),
          bottom: const TabBar(
            tabAlignment: TabAlignment.center,
            labelColor: colorProject.primaryColor,
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: 10),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: colorProject.primaryColor,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(children: [
          WorkerOrderAll(),
          WorkerOrderAccepted(),
          WorkerOrderCompleted(),
          WorkerOrderCancelled(),
        ]),
      ),
    );
  }
}
