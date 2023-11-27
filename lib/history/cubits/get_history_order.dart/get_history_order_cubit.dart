import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/controllers/history.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_state.dart';
import 'package:rmservice/history/models/order.dart';

class GetHistoryOrderCubit extends Cubit<GetHistoryOrderState> {
  GetHistoryOrderCubit() : super(GetHistoryOrderInitial());

  Future<void> getHistory(String userCode) async {
    emit(GetHistoryOrderLoading());
    try {
      List<Order> orders = await HistoryController().getOrders(userCode);
      emit(GetHistoryOrderLoaded(orders));
    } catch (e) {
      emit(GetHistoryOrderError(e.toString()));
    }
  }

  void setInitial() {
    emit(GetHistoryOrderInitial());
  }
}