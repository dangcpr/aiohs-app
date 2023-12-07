import 'package:rmservice/place_page/models/rental_place_res.dart';

abstract class GetPlaceUserState {}

class GetPlaceUserInitial extends GetPlaceUserState {}

class GetPlaceUserLoading extends GetPlaceUserState {}

class GetPlaceUserLoaded extends GetPlaceUserState {
  List<RentalPlaceRes> rentalPlaceRes;
  GetPlaceUserLoaded(this.rentalPlaceRes);
}

class GetPlaceUserError extends GetPlaceUserState {
  String message;
  GetPlaceUserError(this.message);
}