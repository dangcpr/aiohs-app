import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/post_job/repo/post_job_repo.dart';

part 'close_post_state.dart';

class ClosePostCubit extends Cubit<ClosePostState> {
  ClosePostCubit() : super(ClosePostInitial());

  Future<void> closePost(String userCode, String jobCode) async {
    emit(ClosePostLoading());
    try {
      await PostJobRepo().postClose(userCode, jobCode);
      emit(ClosePostSuccess());
    } catch (e) {
      emit(ClosePostFailed(e.toString()));
    }
  }
}
