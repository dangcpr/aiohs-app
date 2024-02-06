part of 'cal_price_cleaning_longterm_cubit.dart';

@immutable
abstract class CalPriceCleaningLongtermState {}

class CalPriceCleaningLongtermInitial extends CalPriceCleaningLongtermState {}

class CalPriceCleaningLongtermLoading extends CalPriceCleaningLongtermState {}

class CalPriceCleaningLongtermSuccess extends CalPriceCleaningLongtermState {
  final int totalPrice;
  CalPriceCleaningLongtermSuccess({required this.totalPrice});
}

class CalPriceCleaningLongtermFailed extends CalPriceCleaningLongtermState {
  final String message;
  CalPriceCleaningLongtermFailed({required this.message});
}
