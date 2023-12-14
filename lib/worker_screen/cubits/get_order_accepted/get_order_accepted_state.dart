import 'package:rmservice/history/models/order.dart';

abstract class WorkerGetOrderAcceptedState {}

class WorkerGetOrderAcceptedInitial extends WorkerGetOrderAcceptedState {}

class WorkerGetOrderAcceptedLoading extends WorkerGetOrderAcceptedState {}

class WorkerGetOrderAcceptedLoaded extends WorkerGetOrderAcceptedState {
  final List<Order> orders;
  WorkerGetOrderAcceptedLoaded(this.orders);
}

class WorkerGetOrderAcceptedError extends WorkerGetOrderAcceptedState {
  final String message;
  WorkerGetOrderAcceptedError(this.message);
}