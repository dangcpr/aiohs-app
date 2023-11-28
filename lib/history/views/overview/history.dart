import 'package:flutter/material.dart';
import 'package:rmservice/history/views/overview/order_cancelled.dart';
import 'package:rmservice/history/views/overview/order_coming.dart';
import 'package:rmservice/history/views/overview/order_completed.dart';
import 'package:rmservice/history/views/overview/order_received.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          flexibleSpace: Column(
            children: [
              TabBar(
                indicatorColor: colorProject.primaryColor,
                labelStyle: TextStyle(
                  color: colorProject.primaryColor,
                  fontFamily: fontBoldApp,
                  fontSize: fontSize.medium,
                ),
                isScrollable: true,
                tabs: [
                  Tab(
                    text: 'Đơn đang chờ',
                  ),
                  Tab(
                    text: 'Đơn đã có giúp việc',
                  ),
                  Tab(text: "Đơn đã hoàn thành"),
                  Tab(
                    text: 'Đơn đã huỷ',
                  )
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryOrderComming(),
            HistoryOrderReceived(),
            HistoryOrderCompleted(),
            HistoryOrderCancelled(),
          ],
        ),
      ),
    );
  }
}
