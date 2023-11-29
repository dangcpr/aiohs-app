import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/cleaning_hourly/models/cleaning_hourly_price.dart';
import 'package:rmservice/cleaning_longterm/model/price_cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/repo/cleaning_longterm_repo.dart';

part 'get_price_cleaning_longterm_state.dart';

class GetPriceCleaningLongtermCubit
    extends Cubit<GetPriceCleaningLongtermState> {
  GetPriceCleaningLongtermCubit() : super(GetPriceCleaningLongtermInitial());

  void getPriceCleaningLongTerm() async {
    emit(GetPriceCleaningLongtermLoading());
    try {
      CleaningLongTermPrice cleaningLongTermPrice =
          await CleaningLongTermRepo().getPriceCleaningLongTerm();
      emit(GetPriceCleaningLongtermSuccess(cleaningLongTermPrice));
    } catch (e) {
      emit(GetPriceCleaningLongtermFailed(e.toString()));
    }
  }
}
