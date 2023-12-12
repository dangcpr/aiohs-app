import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/cubits/get_history_completed/get_history_completed_state.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class GetHistoryCompletedCubit extends Cubit<GetHistoryOrderCompletedState> {
  GetHistoryCompletedCubit() : super(GetHistoryOrderCompletedInitial());

  List<Order> ordersCompleted = [];
  int nextCompleted = 0;

  Future<void> getHistoryCompleted(String userCode) async {
    if (nextCompleted == 0 && state is GetHistoryOrderCompletedLoaded) {
      return;
    }
    emit(GetHistoryOrderCompletedLoading());
    try {
      OrderResult ordersResult =
          await HistoryController().getOrders(userCode, "ORDER_STATUS_DONE", nextCompleted);
      ordersCompleted.addAll(ordersResult.orders);
      nextCompleted = ordersResult.next;
      emit(GetHistoryOrderCompletedLoaded(ordersCompleted));
    } catch (e) {
      emit(GetHistoryOrderCompletedError(e.toString()));
    }
  }

  void setInitialCompleted() {
    nextCompleted = 0;
    ordersCompleted.clear();
    emit(GetHistoryOrderCompletedInitial());
  }
}

