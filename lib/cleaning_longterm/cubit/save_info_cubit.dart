import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_longterm/cubit/price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/model/price_cleaning_longterm.dart';

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

  void addDay(DateTime day) {
    InfoCleaningLongTerm infoCleaningLongTermNew = state;
    infoCleaningLongTermNew.days.add(day);
    emit(infoCleaningLongTermNew);
  }

  void remove(int index) {
    InfoCleaningLongTerm infoCleaningLongTermNew = state;
    infoCleaningLongTermNew.days.removeAt(index);
    emit(infoCleaningLongTermNew);
  }

  void checkStartDay(List<DateTime> days) {
    InfoCleaningLongTerm infoCleaningLongTermNew = state;
    DateTime startDay = days[0];
    for (int i = 0; i < days.length; i++) {
      if (startDay.day >= days[i].day) {
        startDay = days[i];
      }
    }
    infoCleaningLongTermNew.days = days;
    infoCleaningLongTermNew.startDay = startDay;
    emit(infoCleaningLongTermNew);
  }

  void totalPrice(CleaningLongTermPrice cleaningLongTermPrice) {
    state.price = cleaningLongTermPrice.unitPrice *
        state.duration *
        state.days.length *
        state.month *
        4;
    emit(state);
  }

  void updatePaymentMethod(String paymentMethod) {
    state.paymentMethod = paymentMethod;
    emit(state);
  }
}
