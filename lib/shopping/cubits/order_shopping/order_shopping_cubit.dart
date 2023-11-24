import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/controllers/shopping.dart';
import 'package:rmservice/shopping/cubits/order_shopping/order_shopping_state.dart';
import 'package:rmservice/shopping/models/address_shopping.dart';
import 'package:rmservice/shopping/models/info_shopping.dart';

class OrderShoppingCubit extends Cubit<OrderShoppingState> {
  OrderShoppingCubit() : super(OrderShoppingInitial());

  void orderShopping(InfoShopping info, AddressShopping address, String userCode) async {
    emit(OrderShoppingLoading());
    try {
      await ShoppingController().orderShopping(info, address, userCode);
      emit(OrderShoppingSuccess());
    } catch (e) {
      emit(OrderShoppingError(message: e.toString()));
    }
  }

  void setInit() {
    emit(OrderShoppingInitial());
  }
}