import 'package:rmservice/authentication_repository/login_model.dart';

abstract class GetFirstTimeState {}

class GetFirstTimeInitialState extends GetFirstTimeState {}

class GetFirstTimeLoadingState extends GetFirstTimeState {}

class GetFirstTimeLoadedState extends GetFirstTimeState {
  bool? firstTime;
  LoginModel loginModel;
  GetFirstTimeLoadedState(this.firstTime, this.loginModel);
}

class GetFirstTimeErrorState extends GetFirstTimeState {
  String error;
  GetFirstTimeErrorState({required this.error});
}
