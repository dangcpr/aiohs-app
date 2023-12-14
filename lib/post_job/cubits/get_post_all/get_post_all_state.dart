part of 'get_post_all_cubit.dart';

@immutable
abstract class GetPostAllState {}

class GetPostAllInitial extends GetPostAllState {}

class GetPostAllLoading extends GetPostAllState {}

class GetPostAllSuccess extends GetPostAllState {
  List<HistoryJobPosting> posts;
  GetPostAllSuccess(this.posts);
}

class GetPostAllFailed extends GetPostAllState {
  String message;
  GetPostAllFailed(this.message);
}
