abstract class GetFirstTimeState {}

class GetFirstTimeInitialState extends GetFirstTimeState {}

class GetFirstTimeLoadingState extends GetFirstTimeState {}

class GetFirstTimeLoadedState extends GetFirstTimeState {
  bool? firstTime;
  GetFirstTimeLoadedState(this.firstTime);
}

class GetFirstTimeErrorState extends GetFirstTimeState {
  String error;
  GetFirstTimeErrorState({required this.error});
}