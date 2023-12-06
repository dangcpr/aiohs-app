import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../login/models/user.dart';
import '../repo/account_repo.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  Future<void> updateProfile(User newUser) async {
    emit(UpdateProfileLoading());
    try {
      await AccountRepo().updateProfile(newUser);
      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileFailed(e.toString()));
    }
  }
}
