import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_job_info.dart';

class SaveInfoJobPostingCubit extends Cubit<PostJobInfo> {
  SaveInfoJobPostingCubit() : super(PostJobInfo(images: []));

  void setInitial() {
    PostJobInfo postJobInfo = new PostJobInfo(images: []);
    emit(postJobInfo);
  }

  void setInfoJobPosting(PostJobInfo postJobInfo) {
    emit(postJobInfo);
  }
}
