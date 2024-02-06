import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/cooking/model/info_cooking.dart';
import 'package:rmservice/cooking/repo/cooking_repo.dart';

part 'cal_price_state.dart';

class CalPriceCookingCubit extends Cubit<CalPriceCookingState> {
  CalPriceCookingCubit() : super(CalPriceCookingInitial());

  Future<void> calPrice(InfoCooking info) async {
    emit(CalPriceCookingLoading());
    try {
      int price = await CookingRepo().caculatePrice(info);
      emit(CalPriceCookingSuccess(price));
    } catch (e) {
      emit(CalPriceCookingFailed(e.toString()));
    }
  }
}
