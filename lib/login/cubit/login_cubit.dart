import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/login/models/user.dart';

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
      if (res.status == AuthenticationStatus.authenticated) {
        emit(LoginSuccess(statusLogin: res.status.toString(), user: res.user!));
      } else if (res.status == AuthenticationStatus.inactive) {
        emit(LoginFailure(
            error:
                "Tài khoản đang bị khoá. Vui lòng liên hệ quản trị viên"));
      } else {
        emit(LoginFailure(error: "Tài khoản hoặc mật khẩu không đúng"));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> logInGoogle() async {
    emit(LoginLoading());
    try {
      print('Loading');
      var res = await authenticationRepository.logInOauthGoogle();
      if (res.status == AuthenticationStatus.authenticated) {
        emit(LoginSuccess(statusLogin: res.status.toString(), user: res.user!));
      } else if (res.status == AuthenticationStatus.inactive) {
        emit(LoginFailure(
            error:
                "Tài khoản đang bị khoá. Vui lòng liên hệ quản trị viên"));
      } else {
        emit(LoginFailure(error: "Tài khoản hoặc mật khẩu không đúng"));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> logInFB() async {
    emit(LoginLoading());
    try {
      print('Loading');
      var res = await authenticationRepository.logInOauthFacebook();
      if (res.status == AuthenticationStatus.authenticated) {
        emit(LoginSuccess(statusLogin: res.status.toString(), user: res.user!));
      } else if (res.status == AuthenticationStatus.inactive) {
        emit(LoginFailure(
            error:
                "Tài khoản đang bị khoá. Vui lòng liên hệ quản trị viên"));
      } else {
        emit(LoginFailure(error: "Tài khoản hoặc mật khẩu không đúng"));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> setInit() async {
    emit(LoginInitial());
  }
}
