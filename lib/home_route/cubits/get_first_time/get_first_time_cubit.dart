import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/authentication_repository/login_model.dart';
import 'package:rmservice/home_route/controllers/first_time.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_state.dart';

class GetFirstTimeCubit extends Cubit<GetFirstTimeState> {
  GetFirstTimeCubit() : super(GetFirstTimeInitialState());

  Future<void> getFirstTime() async {
    try {
      emit(GetFirstTimeLoadingState());

      final FirstTimeController firstTimeController = FirstTimeController();
      final firstTime = await firstTimeController.getFirstTime();
      await firstTimeController.setRemoteConfig();
      LoginModel loginModel = await AuthenticationRepository().autoLogin();
    
      emit(GetFirstTimeLoadedState(firstTime, loginModel));
    } catch (e) {
      emit(GetFirstTimeErrorState(error: e.toString()));
    }
  }
}
