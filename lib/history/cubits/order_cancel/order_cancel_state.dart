part of 'order_cancel_cubit.dart';

@immutable
abstract class OrderCancelState {}

class OrderCancelInitial extends OrderCancelState {}

class OrderCancelLoading extends OrderCancelState {}

class OrderCancelSuccess extends OrderCancelState {}

class OrderCancelFailed extends OrderCancelState {
  String message;
  OrderCancelFailed(this.message);
}
