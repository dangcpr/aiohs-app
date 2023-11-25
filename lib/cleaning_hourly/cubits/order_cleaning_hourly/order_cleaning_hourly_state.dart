abstract class OrderCleaningHourlyState {}

class OrderCleaningHourlyInitial extends OrderCleaningHourlyState {}

class OrderCleaningHourlyLoading extends OrderCleaningHourlyState {}

class OrderCleaningHourlySuccess extends OrderCleaningHourlyState {}

class OrderCleaningHourlyError extends OrderCleaningHourlyState {
  String message;
  OrderCleaningHourlyError(this.message);
}