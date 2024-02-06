import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/repo/cleaning_longterm_repo.dart';

part 'cal_price_cleaning_longterm_state.dart';

class CalPriceCleaningLongtermCubit
    extends Cubit<CalPriceCleaningLongtermState> {
  CalPriceCleaningLongtermCubit() : super(CalPriceCleaningLongtermInitial());

  Future<void> calculatePrice(InfoCleaningLongTerm info) async {
    emit(CalPriceCleaningLongtermLoading());
    try {
      int price = await CleaningLongTermRepo().caculatePrice(info);
      print('price: $price');
      emit(CalPriceCleaningLongtermSuccess(totalPrice: price));
    } catch (e) {
      emit(CalPriceCleaningLongtermFailed(message: e.toString()));
      print('error: $e');
    }
  }
}
