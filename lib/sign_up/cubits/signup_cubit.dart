import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/sign_up/controllers/main.dart';
import 'package:rmservice/sign_up/cubits/signup_state.dart';
import 'package:rmservice/sign_up/models/user.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  Future<void> signup(UserSignup user) async {
    try {
      emit(SignupLoadingState());

      await SignupController().signup(user);

      emit(SignupCompleteState());
    } catch (e) {
      emit(SignupErrorState(error: e.toString()));
    }
  }

  void setInit() {
    emit(SignupInitialState());
  }
}
