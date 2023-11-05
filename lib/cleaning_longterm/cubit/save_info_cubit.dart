import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';

class SaveInfoCleaningLongTermCubit extends Cubit<InfoCleaningLongTerm> {
  SaveInfoCleaningLongTermCubit()
      : super(InfoCleaningLongTerm(time: DateTime.now(), days: []));

  void setInitial() {
    InfoCleaningLongTerm infoCleaningLongTerm =
        new InfoCleaningLongTerm(days: [], time: DateTime.now());
    emit(infoCleaningLongTerm);
  }

  void setInfoCleaningHourly(InfoCleaningLongTerm infoCleaningLongTerm) {
    emit(infoCleaningLongTerm);
  }

  int checkDay(DateTime day, List<DateTime> days) {
    int i = 0;
    for (i; i < days.length; i++) {
      if (day.day == days[i].day) {
        return i;
      }
    }
    return -1;
  }

  void addDay(DateTime day) =>
      {state.days.add(day), emit(InfoCleaningLongTerm(days: state.days))};

  void remove(int index) => {
        state.days.removeAt(index),
        emit(InfoCleaningLongTerm(days: state.days))
      };

  void checkStartDay(List<DateTime> days) {
    DateTime startDay = days[0];
    for (int i = 0; i < days.length; i++) {
      if (startDay.day >= days[i].day) {
        startDay = days[i];
      }
      emit(InfoCleaningLongTerm(days: days, startDay: startDay));
    }
  }
}
