import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/laundry/controllers/laundry.dart';
import 'package:rmservice/laundry/cubits/get_price_laundry/get_price_laundry_state.dart';
import 'package:rmservice/laundry/models/price_laundry.dart';

class GetPriceLaundryCubit extends Cubit<GetPriceLaundryState> {
  GetPriceLaundryCubit() : super(GetPriceLaundryInitial());

  void getPriceLaundry() async {
    emit(GetPriceLaundryLoading());
    try {
      PriceLaundry priceLaundry = await LaundryController().getLaundryPrice();
      emit(GetPriceLaundrySuccess(priceLaundry));
    }
    catch (e) {
      emit(GetPriceLaundryError(e.toString()));  
    }
  }
}
