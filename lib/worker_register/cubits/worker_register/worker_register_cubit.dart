import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/worker_register/controllers/worker_register.dart';
import 'package:rmservice/worker_register/cubits/worker_register/worker_register_state.dart';

class WorkerRegisterCubit extends Cubit<WorkerRegisterState> {
  WorkerRegisterCubit() : super(WorkerRegisterInitState());

  Future<void> register() async {
    try {
      emit(WorkerRegisterLoadingState());
      await WorkerRegisterController().register();
      debugPrint("Success cubit");
      emit(WorkerRegisterSuccessState());
    } catch (e) {
      emit(WorkerRegisterErrorState(error: e.toString()));
    }
  }

  void setInit() {
    emit(WorkerRegisterInitState());
  }
}
