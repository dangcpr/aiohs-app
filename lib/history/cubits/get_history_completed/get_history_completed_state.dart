import 'package:rmservice/history/models/order.dart';

abstract class GetHistoryOrderCompletedState {}

class GetHistoryOrderCompletedInitial extends GetHistoryOrderCompletedState {}

class GetHistoryOrderCompletedLoading extends GetHistoryOrderCompletedState {}

class GetHistoryOrderCompletedLoaded extends GetHistoryOrderCompletedState {
  List<Order> orders;
  GetHistoryOrderCompletedLoaded(this.orders);
}

class GetHistoryOrderCompletedError extends GetHistoryOrderCompletedState {
  final String message;
  GetHistoryOrderCompletedError(this.message);
}