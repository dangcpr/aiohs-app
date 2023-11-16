abstract class WorkerRegisterState {}

class WorkerRegisterInitState extends WorkerRegisterState {}

class WorkerRegisterErrorState extends WorkerRegisterState {
  final String error;
  WorkerRegisterErrorState({required this.error});
}

class WorkerRegisterLoadingState  extends WorkerRegisterState {}

class WorkerRegisterSuccessState extends WorkerRegisterState {}