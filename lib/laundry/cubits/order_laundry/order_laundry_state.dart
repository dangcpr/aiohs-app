abstract class OrderLaundryState {}

class OrderLaundryInitial extends OrderLaundryState {}

class OrderLaundryLoading extends OrderLaundryState {}

class OrderLaundrySuccess extends OrderLaundryState {}

class OrderLaundryError extends OrderLaundryState {
  final String message;

  OrderLaundryError(this.message);
}