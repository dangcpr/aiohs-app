abstract class CalculatePriceShoppingState {}

class CalculatePriceShoppingInitial extends CalculatePriceShoppingState {}

class CalculatePriceShoppingLoading extends CalculatePriceShoppingState {}

class CalculatePriceShoppingSuccess extends CalculatePriceShoppingState {
  int price;
  CalculatePriceShoppingSuccess({required this.price});
}

class CalculatePriceShoppingError extends CalculatePriceShoppingState {
  String message;
  CalculatePriceShoppingError({required this.message});
}