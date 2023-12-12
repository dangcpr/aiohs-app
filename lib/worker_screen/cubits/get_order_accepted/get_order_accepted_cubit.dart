import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';
import 'package:rmservice/worker_screen/cubits/get_order_accepted/get_order_accepted_state.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class WorkerGetOrderAcceptedCubit extends Cubit<WorkerGetOrderAcceptedState> {
  WorkerGetOrderAcceptedCubit() : super(WorkerGetOrderAcceptedInitial());

  List<Order> orders = [];
  String next = "0";

  Future<void> getOrderAccepted(String userCode) async {
    if (state is WorkerGetOrderAcceptedLoaded && next == "0") {
      return;
    }
    emit(WorkerGetOrderAcceptedLoading());
    try {
      OrderResult orderResult =
          await WorkerController().getOrderMaidAccepted(userCode, next);
      next = orderResult.next.toString();
      orders.addAll(orderResult.orders);
      emit(WorkerGetOrderAcceptedLoaded(orders));
    } catch (e) {
      emit(WorkerGetOrderAcceptedError(e.toString()));
    }
  }

  void initState () {
    orders.clear();
    next = "0";
    emit(WorkerGetOrderAcceptedInitial());
  }
}
