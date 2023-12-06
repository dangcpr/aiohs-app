import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/history/views/detail/laundry.dart';
import 'package:rmservice/history/views/detail/shopping.dart';
import 'package:rmservice/worker_screen/views/detail/worker_cleaning_hourly.dart';

class WorkerHelper {
  void getCleaningHourlyDetail(
      BuildContext context, var userCubit, Order order) async {
    CleaningHourlyHistory cleaningHourlyHistory = await HistoryController()
        .getCleaningHourlyHistory(userCubit.state.code!, order.code);
    debugPrint(cleaningHourlyHistory.toJson().toString());
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: WorkerCleaingHourly(
          order: cleaningHourlyHistory,
        ),
      ),
    );
  }

  void getLaundryDetail(
      BuildContext context, var userCubit, Order order) async {
    LaundryHistory laundryHistory = await HistoryController()
        .getLaundryHistory(userCubit.state.code!, order.code);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: LaundryHistoryDetail(
          order: laundryHistory,
        ),
      ),
    );
  }

  void getShoppingDetail(
      BuildContext context, var userCubit, Order order) async {
    ShoppingHistory laundryHistory = await HistoryController()
        .getShoppingHistory(userCubit.state.code!, order.code);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: ShoppingHistoryDetail(
          order: laundryHistory,
        ),
      ),
    );
  }
}
