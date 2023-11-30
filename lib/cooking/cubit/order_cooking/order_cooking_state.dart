part of 'order_cooking_cubit.dart';

@immutable
abstract class OrderCookingState {}

class OrderCookingInitial extends OrderCookingState {}

class OrderCookingLoading extends OrderCookingState {}

class OrderCookingSuccess extends OrderCookingState {}

class OrderCookingFailed extends OrderCookingState {
  String message;
  OrderCookingFailed(this.message);
}
