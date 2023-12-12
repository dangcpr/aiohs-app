import 'package:rmservice/history/models/order.dart';

abstract class WorkerGetOrderCompletedState {}

class WorkerGetOrderCompletedInitial extends WorkerGetOrderCompletedState {}

class WorkerGetOrderCompletedLoading extends WorkerGetOrderCompletedState {}

class WorkerGetOrderCompletedLoaded extends WorkerGetOrderCompletedState {
  final List<Order> orders;
  WorkerGetOrderCompletedLoaded(this.orders);
}

class WorkerGetOrderCompletedError extends WorkerGetOrderCompletedState {
  final String message;
  WorkerGetOrderCompletedError(this.message);
}