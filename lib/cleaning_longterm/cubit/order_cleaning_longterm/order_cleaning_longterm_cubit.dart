import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/repo/cleaning_longterm_repo.dart';

import '../../../cleaning_hourly/models/address.dart';

part 'order_cleaning_longterm_state.dart';

class OrderCleaningLongtermCubit extends Cubit<OrderCleaningLongtermState> {
  OrderCleaningLongtermCubit() : super(OrderCleaningLongtermInitial());

  void orderCleaningLongTerm(InfoCleaningLongTerm infoCleaningLongTerm,
      Address address, String userCode) async {
    emit(OrderCleaningLongtermLoading());
    try {
      await CleaningLongTermRepo()
          .orderCleaningLongTerm(infoCleaningLongTerm, address, userCode);
      emit(OrderCleaningLongtermSuccess());
    } catch (e) {
      emit(OrderCleaningLongtermFailed(e.toString()));
    }
  }

  void setInit() {
    emit(OrderCleaningLongtermInitial());
  }
}
