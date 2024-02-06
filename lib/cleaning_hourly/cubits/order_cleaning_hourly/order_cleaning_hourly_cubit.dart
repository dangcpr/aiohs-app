import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/controllers/cleaning_hourly.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_state.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';

class OrderCleaningHourlyCubit extends Cubit<OrderCleaningHourlyState> {
  OrderCleaningHourlyCubit() : super(OrderCleaningHourlyInitial());

  Future<String> orderCleaningHourly(InfoCleaningHourly infoCleaningHourly, Address address, String userCode) async {
    emit(OrderCleaningHourlyLoading());
    try {
      String code = await CleaningHourlyController().orderCleaningHourly(infoCleaningHourly, address, userCode);
      emit(OrderCleaningHourlySuccess());
      return code;
    } catch (e) {
      emit(OrderCleaningHourlyError(e.toString()));
      return "";
    }
  }

  void setInit() {
    emit(OrderCleaningHourlyInitial());
  }
}