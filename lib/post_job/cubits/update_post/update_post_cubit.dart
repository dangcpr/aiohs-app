import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/post_job/models/history_job_posting.dart';

import '../../models/post_job_info.dart';
import '../../repo/post_job_repo.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit() : super(UpdatePostInitial());

  Future<void> updatePost(String usercode, PostJobInfo postJobInfo,
      String jobCode, List<File> imagesFile) async {
    emit(UpdatePostILoading());
    try {
      final post = await PostJobRepo()
          .updatePost(usercode, postJobInfo, jobCode, imagesFile);
      emit(UpdatePostSuccess(post));
    } catch (e) {
      emit(UpdatePostFailed(e.toString()));
    }
  }
}
