import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cooking/model/info_cooking.dart';

class SaveInfoCookingCubit extends Cubit<InfoCooking> {
  SaveInfoCookingCubit()
      : super(InfoCooking(
            date: DateTime.now().add(Duration(days: 1)), time: DateTime.now()));

  void setInitial() {
    emit(InfoCooking(date: DateTime.now(), time: DateTime.now()));
  }

  void setInfoCleaningHourly(InfoCooking infoCooking) {
    emit(infoCooking);
  }
}
