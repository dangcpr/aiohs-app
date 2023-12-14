import 'package:rmservice/maid_near/models/maid_rating.dart';

abstract class GetMaidRatingsState {}

class GetMaidRatingsInitial extends GetMaidRatingsState {}

class GetMaidRatingsLoading extends GetMaidRatingsState {}

class GetMaidRatingsSuccess extends GetMaidRatingsState {
  final List<MaidRatingRes> listRating;

  GetMaidRatingsSuccess(this.listRating);
}

class GetMaidRatingsError extends GetMaidRatingsState {
  final String message;

  GetMaidRatingsError(this.message);
}