import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/post_job/repo/post_job_repo.dart';

import '../../models/post_job_info.dart';

part 'post_job_state.dart';

class PostJobCubit extends Cubit<PostJobState> {
  PostJobCubit() : super(PostJobInitial());

  Future<void> postJob(
      String userCode, PostJobInfo postJobInfo, List<File> imagesFile) async {
    emit(PostJobLoading());
    try {
      PostJobRepo().postJob(userCode, postJobInfo, imagesFile);
      emit(PostJobSuccess());
    } catch (e) {
      emit(PostJobFailed(e.toString()));
    }
  }
}
