import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';

class SaveInfoCleaningHourlyCubit extends Cubit<InfoCleaningHourly> {
  SaveInfoCleaningHourlyCubit() : super(InfoCleaningHourly(date: DateTime.now(), time: DateTime.now()));

  void setInitial() {
    emit(InfoCleaningHourly(date: DateTime.now(), time: DateTime.now()));
  }
  void setInfoCleaningHourly(InfoCleaningHourly infoCleaningHourly) {
    emit(infoCleaningHourly);
  }
}