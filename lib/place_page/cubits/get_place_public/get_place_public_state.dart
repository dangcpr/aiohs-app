import 'package:rmservice/place_page/models/rental_place_res.dart';

abstract class GetPlacePublicState {}

class GetPlacePublicInitial extends GetPlacePublicState {}

class GetPlacePublicLoading extends GetPlacePublicState {}

class GetPlacePublicLoaded extends GetPlacePublicState {
  List<RentalPlaceRes> rentalPlaceRes;
  GetPlacePublicLoaded(this.rentalPlaceRes);
}

class GetPlacePublicError extends GetPlacePublicState {
  String message;
  GetPlacePublicError(this.message);
}