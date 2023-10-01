import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/home_route/controllers/first_time.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_state.dart';

class SetFirstTimeCubit extends Cubit<SetFirstTimeState> {
  SetFirstTimeCubit() : super(SetFirstTimeInitialState());

  Future<void> setFirstTime() async {
    try {
      emit(SetFirstTimeLoadingState());

      final FirstTimeController firstTimeController = FirstTimeController();
      await firstTimeController.setFirstTime();

      final firstTime = await firstTimeController.getFirstTime();

      emit(SetFirstTimeLoadedState(firstTime));
    } catch (e) {
      emit(SetFirstTimeErrorState(error: e.toString()));
    }
  }
}
