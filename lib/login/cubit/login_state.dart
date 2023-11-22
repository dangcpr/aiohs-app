part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String statusLogin;
  final User user;
  LoginSuccess({required this.statusLogin, required this.user});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
