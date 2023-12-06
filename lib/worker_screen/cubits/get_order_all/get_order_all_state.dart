import 'package:rmservice/history/models/order.dart';

abstract class WorkerGetOrderAllState {}

class WorkerGetOrderAllInitial extends WorkerGetOrderAllState {}

class WorkerGetOrderAllLoading extends WorkerGetOrderAllState {}

class WorkerGetOrderAllLoaded extends WorkerGetOrderAllState {
  final List<Order> orders;
  WorkerGetOrderAllLoaded(this.orders);
}

class WorkerGetOrderAllError extends WorkerGetOrderAllState {
  final String message;
  WorkerGetOrderAllError(this.message);
}