import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/history/views/detail/cleaning_hourly.dart';

void getCleaningHourlyDetail(BuildContext context, var userCubit, Order order) async {
  CleaningHourlyHistory cleaningHourlyHistory = await HistoryController()
      .getCleaningHourlyHistory(userCubit.state.code!, order.code);
  Navigator.pop(context);
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    PageTransition(
      duration: Duration(milliseconds: 400),
      type: PageTransitionType.rightToLeftWithFade,
      child: CleaningHourlyHistoryDetail(
        order: cleaningHourlyHistory,
      ),
    ),
  );
}
