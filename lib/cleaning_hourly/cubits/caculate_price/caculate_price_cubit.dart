import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/controllers/cleaning_hourly.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_state.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';

class CaculatePriceCleaningHourlyCubit extends Cubit<CaculatePriceCleaningHourlyState> {
  CaculatePriceCleaningHourlyCubit() : super(CaculatePriceCleaningHourlyInitial());

  int priceTotal = 0;

  Future<void> caculatePrice(InfoCleaningHourly info) async {
    emit(CaculatePriceCleaningHourlyLoading());
    try {
      int price = await CleaningHourlyController().caculatePrice(info);
      priceTotal = price;
      emit(CaculatePriceCleaningHourlySuccess(price));
    } catch (e) {
      emit(CaculatePriceCleaningHourlyError(e.toString()));
    }
  }
}