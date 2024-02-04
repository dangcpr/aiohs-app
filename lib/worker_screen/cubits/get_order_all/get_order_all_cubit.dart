import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_state.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class WorkerGetOrderAllCubit extends Cubit<WorkerGetOrderAllState> {
  WorkerGetOrderAllCubit() : super(WorkerGetOrderAllInitial());

  int next = 0;
  List<Order> orders = [];

  Future<void> getOrderAll(
    String userCode, {
    num? distance,
    String? city,
    String? district,
    String? productCode,
  }) async {
    if (state is WorkerGetOrderAllLoaded && next == 0) {
      return;
    }
    emit(WorkerGetOrderAllLoading());
    debugPrint(state.toString());
    try {
      OrderResult orderResult = await WorkerController().getOrderPublic(
        userCode,
        next,
        distance: distance,
        city: city,
        district: district,
        productCode: productCode,
      );
      next = orderResult.next;
      debugPrint(next.toString());
      orders.addAll(orderResult.orders);
      emit(WorkerGetOrderAllLoaded(orders));
    } catch (e) {
      emit(WorkerGetOrderAllError(e.toString()));
    }
  }

  void reset() {
    next = 0;
    orders = [];
    emit(WorkerGetOrderAllInitial());
  }
}
