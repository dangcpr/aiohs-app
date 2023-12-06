import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/cubits/get_history_accepted/get_history_accepted_state.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

class GetHistoryAcceptedCubit extends Cubit<GetHistoryAcceptedState> {
  GetHistoryAcceptedCubit() : super(GetHistoryAcceptedInitial());

  List<Order> ordersAccepted = [];
  int nextAccepted = 0;

  Future<void> getHistoryAccepted(String userCode) async {
    if (nextAccepted == 0 && state is GetHistoryAcceptedLoaded) {
      return;
    }
    emit(GetHistoryAcceptedLoading());
    try {
      OrderResult ordersResult =
          await HistoryController().getOrders(userCode, "ORDER_STATUS_MAID_ACCEPTED", nextAccepted);
      ordersAccepted.addAll(ordersResult.orders);
      nextAccepted = ordersResult.next;
      emit(GetHistoryAcceptedLoaded(ordersAccepted));
    } catch (e) {
      emit(GetHistoryAcceptedError(e.toString()));
    }
  }

  void setInitialAccepted() {
    nextAccepted = 0;
    ordersAccepted.clear();
    emit(GetHistoryAcceptedInitial());
  }

}