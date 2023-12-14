import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../login/models/user.dart';
import '../repo/account_repo.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  Future<void> updateProfile(
      String userCode, String fullName, String phone, String email) async {
    emit(UpdateProfileLoading());
    try {
      var response =
          await AccountRepo().updateProfile(userCode, fullName, phone, email);
      print('Test update profile cubit: ${response.toJson().toString()}');
      emit(UpdateProfileSuccess(response));
    } catch (e) {
      print('Test update profile cubit: ${e.toString()}');
      emit(UpdateProfileFailed(e.toString()));
    }
  }
}
