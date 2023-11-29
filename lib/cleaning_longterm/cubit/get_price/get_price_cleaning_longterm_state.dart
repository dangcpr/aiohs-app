part of 'get_price_cleaning_longterm_cubit.dart';

@immutable
abstract class GetPriceCleaningLongtermState {}

class GetPriceCleaningLongtermInitial extends GetPriceCleaningLongtermState {}

class GetPriceCleaningLongtermLoading extends GetPriceCleaningLongtermState {}

class GetPriceCleaningLongtermSuccess extends GetPriceCleaningLongtermState {
  CleaningLongTermPrice cleaningLongTermPrice;
  GetPriceCleaningLongtermSuccess(this.cleaningLongTermPrice);
}

class GetPriceCleaningLongtermFailed extends GetPriceCleaningLongtermState {
  String message;
  GetPriceCleaningLongtermFailed(this.message);
}
