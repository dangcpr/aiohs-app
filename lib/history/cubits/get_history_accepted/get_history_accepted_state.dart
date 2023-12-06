import 'package:rmservice/history/models/order.dart';

abstract class GetHistoryAcceptedState {}

class GetHistoryAcceptedInitial extends GetHistoryAcceptedState {}

class GetHistoryAcceptedLoading extends GetHistoryAcceptedState {}

class GetHistoryAcceptedLoaded extends GetHistoryAcceptedState {
  List<Order> orders;
  GetHistoryAcceptedLoaded(this.orders);
}

class GetHistoryAcceptedError extends GetHistoryAcceptedState {
  final String message;
  GetHistoryAcceptedError(this.message);
}