import 'package:rmservice/cleaning_hourly/models/cleaning_hourly_price.dart';

abstract class GetPriceCleaningHourlyState {}

class GetPriceCleaningHourlyInitial extends GetPriceCleaningHourlyState {}

class GetPriceCleaningHourlyLoading extends GetPriceCleaningHourlyState {}

class GetPriceCleaningHourlySuccess extends GetPriceCleaningHourlyState {
  CleaningHourlyPrice cleaningHourlyPrice;
  GetPriceCleaningHourlySuccess(this.cleaningHourlyPrice);
}

class GetPriceCleaningHourlyError extends GetPriceCleaningHourlyState {
  String message;
  GetPriceCleaningHourlyError(this.message);
}