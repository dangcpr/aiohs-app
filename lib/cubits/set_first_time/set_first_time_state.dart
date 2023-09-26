abstract class SetFirstTimeState {}

class SetFirstTimeInitialState extends SetFirstTimeState {}

class SetFirstTimeLoadingState extends SetFirstTimeState {}

class SetFirstTimeLoadedState extends SetFirstTimeState {
  bool firstTime;
  SetFirstTimeLoadedState(this.firstTime);
}

class SetFirstTimeErrorState extends SetFirstTimeState {
  String error;
  SetFirstTimeErrorState({required this.error});
}