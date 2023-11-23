import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/controllers/cleaning_hourly.dart';
import 'package:rmservice/cleaning_hourly/cubits/get_price_cleaning_hourly/get_price_cleaning_hourly_state.dart';
import 'package:rmservice/cleaning_hourly/models/cleaning_hourly_price.dart';

class GetPriceCleaningHourlyCubit extends Cubit<GetPriceCleaningHourlyState> {
  GetPriceCleaningHourlyCubit() : super(GetPriceCleaningHourlyInitial());

  void getPriceCleaningHourly() async {
    emit(GetPriceCleaningHourlyLoading());
    try {
      CleaningHourlyPrice cleaningHourlyPrice = await CleaningHourlyController().getPriceCleaningHourly();
      emit(GetPriceCleaningHourlySuccess(cleaningHourlyPrice));
    } catch (e) {
      emit(GetPriceCleaningHourlyError(e.toString()));
    }
  }
}