part of 'update_profile_cubit.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  User user;
  UpdateProfileSuccess(this.user);
}

class UpdateProfileFailed extends UpdateProfileState {
  String message;
  UpdateProfileFailed(this.message);
}
