import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';
import 'package:rmservice/worker_screen/cubits/get_order_completed/get_order_completed_state.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class WorkerGetOrderCompletedCubit extends Cubit<WorkerGetOrderCompletedState> {
  WorkerGetOrderCompletedCubit() : super(WorkerGetOrderCompletedInitial());

  List<Order> orders = [];
  String next = "0";

  Future<void> getOrderCompleted(String userCode) async {
    if (state is WorkerGetOrderCompletedLoaded && next == "0") {
      return;
    }
    emit(WorkerGetOrderCompletedLoading());
    try {
      OrderResult orderResult =
          await WorkerController().getOrderMaidCompleted(userCode, next);
      next = orderResult.next.toString();
      orders.addAll(orderResult.orders);
      emit(WorkerGetOrderCompletedLoaded(orders));
    } catch (e) {
      emit(WorkerGetOrderCompletedError(e.toString()));
    }
  }

  void initState () {
    orders.clear();
    next = "0";
    emit(WorkerGetOrderCompletedInitial());
  }
}