import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/login/models/user.dart';

class LoginModel {
  AuthenticationStatus status;
  User? user;

  LoginModel({required this.status, this.user});
}