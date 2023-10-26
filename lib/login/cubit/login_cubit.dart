import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authenticationRepository}) : super(LoginInitial());

  final AuthenticationRepository authenticationRepository;

  Future<void> logIn(
      {required String username, required String password}) async {
    emit(LoginLoading());
    try {
      print('Loading');
      var res = await authenticationRepository.logIn(
          username: username, password: password);
      if (res == AuthenticationStatus.authenticated) {
        emit(LoginSuccess(statusLogin: res.toString()));
      } else {
        emit(LoginFailure(error: res.toString()));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
