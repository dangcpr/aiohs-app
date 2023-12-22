part of 'update_avatar_cubit.dart';

@immutable
abstract class UpdateAvatarState {}

class UpdateAvatarInitial extends UpdateAvatarState {}

class UpdateAvatarLoading extends UpdateAvatarState {}

class UpdateAvatarSuccess extends UpdateAvatarState {
  User user;
  UpdateAvatarSuccess(this.user);
}

class UpdateAvatarFailed extends UpdateAvatarState {
  String message;
  UpdateAvatarFailed(this.message);
}
