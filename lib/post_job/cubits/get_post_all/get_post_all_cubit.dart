import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/post_job/models/post_result.dart';
import 'package:rmservice/post_job/repo/post_job_repo.dart';

import '../../models/history_job_posting.dart';

part 'get_post_all_state.dart';

class GetPostAllCubit extends Cubit<GetPostAllState> {
  GetPostAllCubit() : super(GetPostAllInitial());

  String next = "0";
  List<HistoryJobPosting> posts = [];

  Future<void> getPostAll(double distance, String userCode) async {
    if (posts.isNotEmpty && next == "0") {
      return;
    }
    emit(GetPostAllLoading());
    //debugPrint(state.toString());
    try {
      PostResult postResult =
          await PostJobRepo().getPostAll(distance, userCode, next);
      next = postResult.next;
      //debugPrint(next.toString());
      posts.addAll(postResult.posts);
      emit(GetPostAllSuccess(posts));
    } catch (e) {
      emit(GetPostAllFailed(e.toString()));
    }
  }

  void reset() {
    next = "0";
    posts = [];
    emit(GetPostAllInitial());
  }
}
