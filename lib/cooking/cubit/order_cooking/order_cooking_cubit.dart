import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/cooking/model/info_cooking.dart';
import 'package:rmservice/cooking/repo/cooking_repo.dart';

import '../../../cleaning_hourly/models/address.dart';

part 'order_cooking_state.dart';

class OrderCookingCubit extends Cubit<OrderCookingState> {
  OrderCookingCubit() : super(OrderCookingInitial());

  void orderCooking(
      InfoCooking infoCooking, Address address, String userCode) async {
    emit(OrderCookingLoading());
    try {
      await CookingRepo().orderCooking(infoCooking, address, userCode);
      emit(OrderCookingSuccess());
    } catch (e) {
      emit(OrderCookingFailed(e.toString()));
    }
  }

  void setInit() {
    emit(OrderCookingInitial());
  }
}
