part of 'get_history_cancel_cubit.dart';

@immutable
abstract class GetHistoryCancelState {}

class GetHistoryCancelInitial extends GetHistoryCancelState {}

class GetHistoryCancelLoading extends GetHistoryCancelState {}

class GetHistoryCancelSuccess extends GetHistoryCancelState {
  List<Order> orders;
  GetHistoryCancelSuccess(this.orders);
}

class GetHistoryCancelFailed extends GetHistoryCancelState {
  final String message;
  GetHistoryCancelFailed(this.message);
}
