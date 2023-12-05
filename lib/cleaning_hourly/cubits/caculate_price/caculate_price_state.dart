abstract class CaculatePriceCleaningHourlyState {}

class CaculatePriceCleaningHourlyInitial extends CaculatePriceCleaningHourlyState {}

class CaculatePriceCleaningHourlyLoading extends CaculatePriceCleaningHourlyState {}

class CaculatePriceCleaningHourlySuccess extends CaculatePriceCleaningHourlyState {
  int price;
  
  CaculatePriceCleaningHourlySuccess(this.price);
}

class CaculatePriceCleaningHourlyError extends CaculatePriceCleaningHourlyState {
  String message;
  CaculatePriceCleaningHourlyError(this.message);
}