part of 'cal_price_cubit.dart';

@immutable
abstract class CalPriceCookingState {}

class CalPriceCookingInitial extends CalPriceCookingState {}

class CalPriceCookingLoading extends CalPriceCookingState {}

class CalPriceCookingSuccess extends CalPriceCookingState {
  final int cookingPrice;

  CalPriceCookingSuccess(this.cookingPrice);
}

class CalPriceCookingFailed extends CalPriceCookingState {
  final String message;

  CalPriceCookingFailed(this.message);
}
