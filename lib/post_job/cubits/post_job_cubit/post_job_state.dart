part of 'post_job_cubit.dart';

@immutable
abstract class PostJobState {}

class PostJobInitial extends PostJobState {}

class PostJobLoading extends PostJobState {}

class PostJobSuccess extends PostJobState {}

class PostJobFailed extends PostJobState {
  String message;
  PostJobFailed(this.message);
}
