import 'package:rmservice/history/models/order.dart';

abstract class WorkerGetOrderCancelledState {}

class WorkerGetOrderCancelledInitial extends WorkerGetOrderCancelledState {}

class WorkerGetOrderCancelledLoading extends WorkerGetOrderCancelledState {}

class WorkerGetOrderCancelledLoaded extends WorkerGetOrderCancelledState {
  final List<Order> orders;
  WorkerGetOrderCancelledLoaded(this.orders);
}

class WorkerGetOrderCancelledError extends WorkerGetOrderCancelledState {
  final String message;
  WorkerGetOrderCancelledError(this.message);
}