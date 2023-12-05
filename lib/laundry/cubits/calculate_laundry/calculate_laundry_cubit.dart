import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/controllers/laundry.dart';
import 'package:rmservice/laundry/cubits/calculate_laundry/calculate_laundry_state.dart';
import 'package:rmservice/laundry/models/info_laundry.dart';

class CalculateLaundryCubit extends Cubit<CalculateLaundryState> {
  CalculateLaundryCubit() : super(CalculateLaundryInitial());

  int totalPrice = 0;
  Future<void> calculateLaundry(InfoLaundry info) async {
    emit(CalculateLaundryLoading());
    try {
      int price = await LaundryController().calculateLaundry(info);
      totalPrice = price;
      emit(CalculateLaundrySuccess(price));
    } catch (e) {
      emit(CalculateLaundryError(e.toString()));
    }
  }
}