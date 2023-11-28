import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/repo/air_conditioning_cleaning_repo.dart';

import '../../../cleaning_hourly/models/address.dart';

part 'order_air_cond_state.dart';

class OrderAirCondCubit extends Cubit<OrderAirCondState> {
  OrderAirCondCubit() : super(OrderAirCondInitial());

  void orderAirCond(InfoAirConditioningCleaning infoAirConditioningCleaning,
      Address address, String userCode) async {
    emit(OrderAirCondLoading());
    try {
      await AirCondRepo()
          .orderAirCond(infoAirConditioningCleaning, address, userCode);
      emit(OrderAirCondSuccess());
    } catch (e) {
      emit(OrderAirCondFailed(e.toString()));
    }
  }

  void setInit() {
    emit(OrderAirCondInitial());
  }
}
