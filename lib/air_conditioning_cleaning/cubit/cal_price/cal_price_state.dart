part of 'cal_price_cubit.dart';

@immutable
abstract class CalPriceState {}

class CalPriceInitial extends CalPriceState {}

class CalPriceLoading extends CalPriceState {}

class CalPriceSuccess extends CalPriceState {
  final int price;

  CalPriceSuccess(this.price);
}

class CalPriceFailed extends CalPriceState {
  final String message;

  CalPriceFailed(this.message);
}
