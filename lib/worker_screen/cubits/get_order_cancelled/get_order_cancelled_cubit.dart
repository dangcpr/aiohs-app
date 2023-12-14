import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';
import 'package:rmservice/worker_screen/cubits/get_order_cancelled/get_order_cancelled_state.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class WorkerGetOrderCancelledCubit extends Cubit<WorkerGetOrderCancelledState> {
  WorkerGetOrderCancelledCubit() : super(WorkerGetOrderCancelledInitial());

  List<Order> orders = [];
  String next = "0";

  Future<void> getOrderCancelled(String userCode) async {
    if (state is WorkerGetOrderCancelledLoaded && next == "0") {
      return;
    }
    emit(WorkerGetOrderCancelledLoading());
    try {
      OrderResult orderResult =
          await WorkerController().getOrderMaidCancelled(userCode, next);
      next = orderResult.next.toString();
      orders.addAll(orderResult.orders);
      emit(WorkerGetOrderCancelledLoaded(orders));
    } catch (e) {
      emit(WorkerGetOrderCancelledError(e.toString()));
    }
  }

  void initState () {
    orders = [];
    next = "0";
    emit(WorkerGetOrderCancelledInitial());
  }
}