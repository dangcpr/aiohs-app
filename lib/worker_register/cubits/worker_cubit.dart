import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/worker_register/models/worker.dart';

class WorkerCubit extends Cubit<Worker> {
  WorkerCubit() : super(Worker());

  void setWorker(Worker worker) {
    emit(worker);
  }

  void setIDImage(File idF, File idB) {
    Worker newState = state;
    newState.idF = idF;
    newState.idB = idB;
    emit(newState);
  }
}