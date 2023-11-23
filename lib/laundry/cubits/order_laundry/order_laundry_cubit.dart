import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/laundry/controllers/order_laundry.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_state.dart';
import 'package:rmservice/laundry/models/info_laundry.dart';

class OrderLaundryCubit extends Cubit<OrderLaundryState> {
  OrderLaundryCubit() : super(OrderLaundryInitial());

  Future<void> orderLaundry(InfoLaundry infoLaundry, Address address,
      String userCode) async {
    emit(OrderLaundryLoading());
    try {
      await LaudryController()
          .orderLaundry(infoLaundry, address, userCode);
      emit(OrderLaundrySuccess());
    } catch (e) {
      emit(OrderLaundryError(e.toString()));
    }
  }

  void setInit() {
    emit(OrderLaundryInitial());
  }
}
