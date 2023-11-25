import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';

class SaveInfoAirConditioningCleaningCubit
    extends Cubit<InfoAirConditioningCleaning> {
  SaveInfoAirConditioningCleaningCubit()
      : super(InfoAirConditioningCleaning(
            time: DateTime.now(),
            details: [],
            date: DateTime.now().add(Duration(days: 1))));

  void setInitial() {
    InfoAirConditioningCleaning infoAirConditioningCleaning =
        new InfoAirConditioningCleaning(
            time: DateTime.now(),
            details: [],
            date: DateTime.now().add(Duration(days: 1)));
    emit(infoAirConditioningCleaning);
  }

  void setInfoAirConditioningCleaning(
      InfoAirConditioningCleaning infoAirConditioningCleaning) {
    emit(infoAirConditioningCleaning);
  }

  void printListItem() {
    for (int i = 0; i < state.details.length; i++) {
      print('------- Item $i -------');
      print(state.details[i].type);
      print(state.details[i].detail);
      print(state.details[i].amount);
      print(state.details[i].hasGas);
      print('------- End Item $i -------');
    }
  }

  void addDetail(Details detail) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    infoAirConditioningCleaning.details.add(detail);

    emit(infoAirConditioningCleaning);
  }

  Details createNewDetail({required String type, required String info}) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    Details detail = Details(type: type, detail: info);
    int index = checkIndex(detail, state.details);
    if (index != -1) {
      return state.details[index];
    } else
      infoAirConditioningCleaning.details.add(detail);
    emit(infoAirConditioningCleaning);
    printListItem();

    return detail;
  }

  int checkIndex(Details detail, List<Details> details) {
    int i = 0;
    for (i; i < details.length; i++) {
      if (detail.detail == details[i].detail) {
        return i;
      }
    }
    return -1;
  }

  void deleteDuplicateItem() {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    for (int i = 0; i < state.details.length; i++) {
      int index = checkIndex(state.details[i], state.details);
      if (index != -1) {
        removeDetail(state.details[index]);
      }
    }

    printListItem();

    emit(state);
  }

  void removeDetail(Details detail) {
    InfoAirConditioningCleaning infoAirConditioningCleaning = state;
    int index = checkIndex(detail, state.details);
    if (index != -1) {
      infoAirConditioningCleaning.details.removeAt(index);
    }
    printListItem();

    emit(infoAirConditioningCleaning);
  }
}
