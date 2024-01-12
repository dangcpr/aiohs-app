import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/history/cubits/get_history_cancel/get_history_cancel_cubit.dart';
import 'package:rmservice/post_job/models/post_result.dart';
import 'package:rmservice/post_job/repo/post_job_repo.dart';

import '../../models/history_job_posting.dart';

part 'get_history_post_state.dart';

class GetHistoryPostCubit extends Cubit<GetHistoryPostState> {
  GetHistoryPostCubit() : super(GetHistoryPostInitial());

  List<HistoryJobPosting> posts = [];
  // List<HistoryJobPosting> ordersAccepted = [];
  // int next = 0;
  // int nextAccepted = 0;

  Future<void> getHistory(String userCode, String status) async {
    emit(GetHistoryPostLoading());
    try {
      PostResult postResult = await PostJobRepo().getPost(userCode, status);
      posts.addAll(postResult.posts);
      emit(GetHistoryPostSuccess(posts));
    } catch (e) {
      print(e.toString());
      emit(GetHistoryPostFailed(e.toString()));
    }
  }

  void setInitial() {
    posts.clear();
    emit(GetHistoryPostInitial());
  }
}
