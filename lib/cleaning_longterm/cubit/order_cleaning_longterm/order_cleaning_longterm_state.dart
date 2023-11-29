part of 'order_cleaning_longterm_cubit.dart';

@immutable
abstract class OrderCleaningLongtermState {}

class OrderCleaningLongtermInitial extends OrderCleaningLongtermState {}

class OrderCleaningLongtermLoading extends OrderCleaningLongtermState {}

class OrderCleaningLongtermSuccess extends OrderCleaningLongtermState {}

class OrderCleaningLongtermFailed extends OrderCleaningLongtermState {
  String message;
  OrderCleaningLongtermFailed(this.message);
}
