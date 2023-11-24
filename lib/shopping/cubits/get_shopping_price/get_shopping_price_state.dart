import 'package:rmservice/shopping/models/shopping_price.dart';

abstract class GetShoppingPriceState {}

class GetShoppingPriceInitial extends GetShoppingPriceState {}

class GetShoppingPriceLoading extends GetShoppingPriceState {}

class GetShoppingPriceSuccess extends GetShoppingPriceState {
  ShoppingPrice shoppingPrice;
  GetShoppingPriceSuccess({required this.shoppingPrice});
}

class GetShoppingPriceError extends GetShoppingPriceState {
  String message;
  GetShoppingPriceError({required this.message});
}