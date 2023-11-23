import 'package:rmservice/laundry/models/price_laundry.dart';

abstract class GetPriceLaundryState {}

class GetPriceLaundryInitial extends GetPriceLaundryState {}

class GetPriceLaundryLoading extends GetPriceLaundryState {}

class GetPriceLaundrySuccess extends GetPriceLaundryState {
  PriceLaundry priceLaundry;
  GetPriceLaundrySuccess(this.priceLaundry);
}

class GetPriceLaundryError extends GetPriceLaundryState {
  final String message;

  GetPriceLaundryError(this.message);
}