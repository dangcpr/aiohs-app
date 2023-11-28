part of 'order_air_cond_cubit.dart';

@immutable
abstract class OrderAirCondState {}

class OrderAirCondInitial extends OrderAirCondState {}

class OrderAirCondLoading extends OrderAirCondState {}

class OrderAirCondSuccess extends OrderAirCondState {}

class OrderAirCondFailed extends OrderAirCondState {
  String message;
  OrderAirCondFailed(this.message);
}
