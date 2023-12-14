part of 'get_history_post_cubit.dart';

@immutable
abstract class GetHistoryPostState {}

class GetHistoryPostInitial extends GetHistoryPostState {}

class GetHistoryPostLoading extends GetHistoryPostState {}

class GetHistoryPostSuccess extends GetHistoryPostState {
  List<HistoryJobPosting> posts;
  GetHistoryPostSuccess(this.posts);
}

class GetHistoryPostFailed extends GetHistoryPostState {
  String message;
  GetHistoryPostFailed(this.message);
}
