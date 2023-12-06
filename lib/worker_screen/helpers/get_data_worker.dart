import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/models/air_conditioning_history.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/history/models/cleaning_longterm_history.dart';
import 'package:rmservice/history/models/cooking_history.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/worker_screen/views/detail/Worker_cleaning_air_cond.dart';
import 'package:rmservice/worker_screen/views/detail/worker_cleaning_hourly.dart';
import 'package:rmservice/worker_screen/views/detail/worker_cleaning_longterm.dart';
import 'package:rmservice/worker_screen/views/detail/worker_cooking.dart';
import 'package:rmservice/worker_screen/views/detail/worker_laundry.dart';
import 'package:rmservice/worker_screen/views/detail/worker_shopping.dart';

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
        child: WorkerLaundry(
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
        child: WorkerShopping(
          order: laundryHistory,
        ),
      ),
    );
  }

  void getCleaningLongTermDetail(
      BuildContext context, var userCubit, Order order) async {
    CleaningLongTermHistory cleaningLongTermHistory = await HistoryController()
        .getCleaningLongTermHistory(userCubit.state.code!, order.code);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: CleaningLongTermHistoryDetail(
          order: cleaningLongTermHistory,
        ),
      ),
    );
  }

  void getCleaningAirCondDetail(
      BuildContext context, var userCubit, Order order) async {
    CleaningAirCondHistory cleaningAirCondHistory = await HistoryController()
        .getCleaningAirCondHistory(userCubit.state.code!, order.code);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: CleaningAirCondHistoryDetail(
          order: cleaningAirCondHistory,
        ),
      ),
    );
  }

  void getCookingDetail(
      BuildContext context, var userCubit, Order order) async {
    CookingHistory cookingHistory = await HistoryController()
        .getCookingHistory(userCubit.state.code!, order.code);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: WorkerCookingHistoryDetail(
          order: cookingHistory,
        ),
      ),
    );
  }
}
