import 'package:flutter_bloc/flutter_bloc.dart';

class SavePhoneCleaningHourlyCubit extends Cubit<String> {
  SavePhoneCleaningHourlyCubit() : super("");

  void setInitial() {
    emit("");
  }
  void setNameCleaningHourly(String phone) {
    emit(phone);
  }
}