abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupCompleteState extends SignupState {

}

class SignupErrorState extends SignupState {
  final String error;
  SignupErrorState({required this.error});
}