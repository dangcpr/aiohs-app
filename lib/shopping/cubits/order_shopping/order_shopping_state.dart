abstract class OrderShoppingState {}

class OrderShoppingInitial extends OrderShoppingState {}

class OrderShoppingLoading extends OrderShoppingState {}

class OrderShoppingSuccess extends OrderShoppingState {}

class OrderShoppingError extends OrderShoppingState {
  String message;
  OrderShoppingError({required this.message});
}