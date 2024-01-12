import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/login/models/user.dart';

import '../../repo/account_repo.dart';

part 'update_avatar_state.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  UpdateAvatarCubit() : super(UpdateAvatarInitial());

  Future<void> updateAvatar(String userCode, File avatarUrl) async {
    emit(UpdateAvatarLoading());
    try {
      var response = await AccountRepo().updateAvatar(userCode, avatarUrl);
      emit(UpdateAvatarSuccess(response));
    } catch (e) {
      emit(UpdateAvatarFailed(e.toString()));
    }
  }
}
