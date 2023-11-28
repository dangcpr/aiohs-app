part of 'get_price_air_cond_cubit.dart';

@immutable
abstract class GetPriceAirCondState {}

class GetPriceAirCondInitial extends GetPriceAirCondState {}

class GetPriceAirCondLoading extends GetPriceAirCondState {}

class GetPriceAirCondSuccess extends GetPriceAirCondState {
  AirCondPrice airCondPrice;
  GetPriceAirCondSuccess(this.airCondPrice);
}

class GetPriceAirCondFailed extends GetPriceAirCondState {
  String message;
  GetPriceAirCondFailed(this.message);
}
