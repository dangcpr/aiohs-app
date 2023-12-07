import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/history/controllers/history_cancelled.dart';

part 'order_cancel_state.dart';

class OrderCancelCubit extends Cubit<OrderCancelState> {
  OrderCancelCubit() : super(OrderCancelInitial());

  Future<void> orderCancel(String userCode, String orderCode) async {
    emit(OrderCancelLoading());
    try {
      HistoryCancelled().ordersCancelled(userCode, orderCode);
      emit(OrderCancelSuccess());
    } catch (e) {
      emit(OrderCancelFailed(e.toString()));
    }
  }
}
