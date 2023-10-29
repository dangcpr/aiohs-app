import 'package:flutter_bloc/flutter_bloc.dart';

class SaveNameCleaningHourlyCubit extends Cubit<String> {
  SaveNameCleaningHourlyCubit() : super("");

  void setInitial() {
    emit("");
  }
  void setNameCleaningHourly(String name) {
    emit(name);
  }
}