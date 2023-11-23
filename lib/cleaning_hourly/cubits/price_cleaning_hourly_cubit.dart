import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/cleaning_hourly_price.dart';

class PriceCleaningHourlyCubit extends Cubit<CleaningHourlyPrice> {
  PriceCleaningHourlyCubit() : super(CleaningHourlyPrice());

  void setPriceCleaningHourly(CleaningHourlyPrice cleaningHourlyPrice) {
    emit(cleaningHourlyPrice);
  }
}