import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/account/cubits/logout/logout_state.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout(String userCode) async {
    emit(LogoutLoading());
    try {
      await AuthenticationRepository().logOut(userCode);
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(error: e.toString()));
    }
  }
}