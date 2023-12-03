import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/controllers/shopping.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_state.dart';
import 'package:rmservice/shopping/models/info_shopping.dart';

class CalculatePriceShoppingCubit extends Cubit<CalculatePriceShoppingState> {
  CalculatePriceShoppingCubit() : super(CalculatePriceShoppingInitial());
  int priceTotal = 0;

  Future<void> calculatePrice(InfoShopping info, int amount) async {
    emit(CalculatePriceShoppingLoading());
    try {
      info.price = amount;
      int price = await ShoppingController().caculateShopping(info);
      priceTotal = price;
      emit(CalculatePriceShoppingSuccess(price: price));
    } catch (e) {
      priceTotal = 0;
      emit(CalculatePriceShoppingError(message: e.toString()));
    }
  }
}
