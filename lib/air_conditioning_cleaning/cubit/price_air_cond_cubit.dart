import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/model/air_conditioning_cleaning_price.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';

class AirCondPriceCubit extends Cubit<AirCondPrice> {
  AirCondPriceCubit() : super(AirCondPrice());

  void setPriceCleaningHourly(AirCondPrice airCondPrice) {
    emit(airCondPrice);
  }
}
