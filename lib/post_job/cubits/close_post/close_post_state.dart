part of 'close_post_cubit.dart';

@immutable
abstract class ClosePostState {}

class ClosePostInitial extends ClosePostState {}

class ClosePostLoading extends ClosePostState {}

class ClosePostSuccess extends ClosePostState {}

class ClosePostFailed extends ClosePostState {
  String message;
  ClosePostFailed(this.message);
}
