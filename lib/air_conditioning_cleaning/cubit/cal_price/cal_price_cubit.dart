import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/repo/air_conditioning_cleaning_repo.dart';

part 'cal_price_state.dart';

class CalPriceCubit extends Cubit<CalPriceState> {
  CalPriceCubit() : super(CalPriceInitial());

  Future<void> calPrice(InfoAirConditioningCleaning info) async {
    emit(CalPriceLoading());
    try {
      int price = await AirCondRepo().caculatePrice(info);
      emit(CalPriceSuccess(price));
    } catch (e) {
      emit(CalPriceFailed(e.toString()));
    }
  }
}
