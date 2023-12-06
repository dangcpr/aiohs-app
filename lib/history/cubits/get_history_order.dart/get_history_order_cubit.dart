import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_state.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class GetHistoryOrderCubit extends Cubit<GetHistoryOrderState> {
  GetHistoryOrderCubit() : super(GetHistoryOrderInitial());

  List<Order> orders = [];
  List<Order> ordersAccepted = [];
  int next = 0;
  int nextAccepted = 0;

  Future<void> getHistory(String userCode, String status) async {
    if (next == 0 && state is GetHistoryOrderLoaded) {
      return;
    }
    emit(GetHistoryOrderLoading());
    try {
      OrderResult ordersResult =
          await HistoryController().getOrders(userCode, status, next);
      orders.addAll(ordersResult.orders);
      next = ordersResult.next;
      emit(GetHistoryOrderLoaded(orders));
    } catch (e) {
      emit(GetHistoryOrderError(e.toString()));
    }
  }

  void setInitial() {
    next = 0;
    orders.clear();
    emit(GetHistoryOrderInitial());
  }

  Future<void> getHistoryAccepted(String userCode, String status) async {
    if (nextAccepted == 0 && state is GetHistoryOrderLoaded) {
      return;
    }
    emit(GetHistoryOrderLoading());
    try {
      OrderResult ordersResult =
          await HistoryController().getOrders(userCode, status, nextAccepted);
      ordersAccepted.addAll(ordersResult.orders);
      nextAccepted = ordersResult.next;
      emit(GetHistoryOrderLoaded(ordersAccepted));
    } catch (e) {
      emit(GetHistoryOrderError(e.toString()));
    }
  }

  void setInitialAccepted() {
    nextAccepted = 0;
    ordersAccepted.clear();
    emit(GetHistoryOrderInitial());
  }
}
