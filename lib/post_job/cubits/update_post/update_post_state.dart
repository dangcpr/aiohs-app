part of 'update_post_cubit.dart';

@immutable
abstract class UpdatePostState {}

class UpdatePostInitial extends UpdatePostState {}

class UpdatePostILoading extends UpdatePostState {}

class UpdatePostSuccess extends UpdatePostState {
  HistoryJobPosting historyJobPosting;
  UpdatePostSuccess(this.historyJobPosting);
}

class UpdatePostFailed extends UpdatePostState {
  String message;
  UpdatePostFailed(this.message);
}
