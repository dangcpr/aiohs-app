part of 'get_price_cooking_cubit.dart';

@immutable
abstract class GetPriceCookingState {}

class GetPriceCookingInitial extends GetPriceCookingState {}

class GetPriceCookingLoading extends GetPriceCookingState {}

class GetPriceCookingSuccess extends GetPriceCookingState {
  CookingPrice cookingPrice;
  GetPriceCookingSuccess(this.cookingPrice);
}

class GetPriceCookingFailed extends GetPriceCookingState {
  String message;
  GetPriceCookingFailed(this.message);
}
