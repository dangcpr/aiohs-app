import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';

class SaveInfoCleaningHourlyCubit extends Cubit<InfoCleaningHourly> {
  SaveInfoCleaningHourlyCubit()
      : super(InfoCleaningHourly(
            date: DateTime.now().add(Duration(days: 1)), time: DateTime.now()));

  void setInitial() {
    emit(InfoCleaningHourly(date: DateTime.now(), time: DateTime.now()));
  }

  void setInfoCleaningHourly(InfoCleaningHourly infoCleaningHourly) {
    emit(infoCleaningHourly);
  }

  void updateDuration(int duration) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.duration = duration;
    infoCleaningHourly.realDuration = infoCleaningHourly.duration! +
        (infoCleaningHourly.cooking == true ? 1 : 0) +
        (infoCleaningHourly.iron == true ? 1 : 0);
    emit(infoCleaningHourly);
  }

  void updateDate(DateTime date) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.date = date;
    emit(infoCleaningHourly);
  }

  void updateTime(DateTime time) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.time = time;
    emit(infoCleaningHourly);
  }

  void updateNote(String note) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.note = note;
    emit(infoCleaningHourly);
  }

  void updateCooking(bool cooking) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.cooking = cooking;
    infoCleaningHourly.realDuration = infoCleaningHourly.duration! +
        (infoCleaningHourly.cooking == true ? 1 : 0) +
        (infoCleaningHourly.iron == true ? 1 : 0);
    emit(infoCleaningHourly);
  }

  void updateIron(bool iron) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.iron = iron;
    infoCleaningHourly.realDuration = infoCleaningHourly.duration! +
        (infoCleaningHourly.cooking == true ? 1 : 0) +
        (infoCleaningHourly.iron == true ? 1 : 0);
    emit(infoCleaningHourly);
  }

  void updateBringTool(bool bringTool) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.bringTool = bringTool;
    emit(infoCleaningHourly);
  }

  void updatePrice(int price) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.price = price;
    emit(infoCleaningHourly);
  }

  void updatePaymentMethod(String paymentMethod) {
    InfoCleaningHourly infoCleaningHourly = state;
    infoCleaningHourly.paymentMethod = paymentMethod;
    emit(infoCleaningHourly);
  }
}
