abstract class CalculateLaundryState {}

class CalculateLaundryInitial extends CalculateLaundryState {}

class CalculateLaundryLoading extends CalculateLaundryState {}

class CalculateLaundrySuccess extends CalculateLaundryState {
  int price;
  CalculateLaundrySuccess(this.price);
}

class CalculateLaundryError extends CalculateLaundryState {
  final String message;

  CalculateLaundryError(this.message);
}