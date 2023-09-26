import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/controllers/system/first_time.dart';
import 'package:rmservice/cubits/get_first_time/get_first_time_state.dart';

class GetFirstTimeCubit extends Cubit<GetFirstTimeState> {
  GetFirstTimeCubit() : super(GetFirstTimeInitialState());

  Future<void> getFirstTime() async {
    try {
      emit(GetFirstTimeLoadingState());

      final FirstTimeController firstTimeController = FirstTimeController();
      final firstTime = await firstTimeController.getFirstTime();

      emit(GetFirstTimeLoadedState(firstTime));
    } catch (e) {
      emit(GetFirstTimeErrorState(error: e.toString()));
    }
  }
}