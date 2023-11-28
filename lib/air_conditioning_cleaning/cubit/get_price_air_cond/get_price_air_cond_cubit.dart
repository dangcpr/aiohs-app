import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rmservice/air_conditioning_cleaning/model/air_conditioning_cleaning_price.dart';

import '../../repo/air_conditioning_cleaning_repo.dart';

part 'get_price_air_cond_state.dart';

class GetPriceAirCondCubit extends Cubit<GetPriceAirCondState> {
  GetPriceAirCondCubit() : super(GetPriceAirCondInitial());

  void getPriceAirCond() async {
    emit(GetPriceAirCondLoading());
    try {
      AirCondPrice airCondPrice = await AirCondRepo().getPriceAirCond();
      emit(GetPriceAirCondSuccess(airCondPrice));
    } catch (e) {
      emit(GetPriceAirCondFailed(e.toString()));
    }
  }
}
