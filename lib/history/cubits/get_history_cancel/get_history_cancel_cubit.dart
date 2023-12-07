import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/history/controllers/history_cancelled.dart';

import '../../models/order.dart';

part 'get_history_cancel_state.dart';

class GetHistoryCancelCubit extends Cubit<GetHistoryCancelState> {
  GetHistoryCancelCubit() : super(GetHistoryCancelInitial());

  Future<void> getHistoryCancel(String userCode) async {
    emit(GetHistoryCancelLoading());
    try {
      List<Order> orders =
          await HistoryCancelled().getOrdersCancelled(userCode);
      emit(GetHistoryCancelSuccess(orders));
    } catch (e) {
      emit(GetHistoryCancelFailed(e.toString()));
    }
  }

  void setInitial() {
    emit(GetHistoryCancelInitial());
  }
}
