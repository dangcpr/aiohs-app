import 'package:rmservice/history/models/order.dart';

abstract class GetHistoryOrderState {}

class GetHistoryOrderInitial extends GetHistoryOrderState {}

class GetHistoryOrderLoading extends GetHistoryOrderState {}

class GetHistoryOrderLoaded extends GetHistoryOrderState {
  List<Order> orders;
  GetHistoryOrderLoaded(this.orders);
}

class GetHistoryOrderError extends GetHistoryOrderState {
  final String message;
  GetHistoryOrderError(this.message);
}