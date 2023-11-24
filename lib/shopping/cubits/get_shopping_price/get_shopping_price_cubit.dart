import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/controllers/shopping.dart';
import 'package:rmservice/shopping/cubits/get_shopping_price/get_shopping_price_state.dart';
import 'package:rmservice/shopping/models/shopping_price.dart';

class GetShoppingPriceCubit extends Cubit<GetShoppingPriceState> {
  GetShoppingPriceCubit() : super(GetShoppingPriceInitial());

  Future<void> getShoppingPrice() async {
    emit(GetShoppingPriceLoading());
    try {
      ShoppingPrice shoppingPrice =
          await ShoppingController().getShoppingPrice();
      emit(GetShoppingPriceSuccess(shoppingPrice: shoppingPrice));
    } catch (e) {
      emit(GetShoppingPriceError(message: e.toString()));
    }
  }

  void setInit() {
    emit(GetShoppingPriceInitial());
  }
}
