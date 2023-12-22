import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/models/product_buy.dart';

class AddItemCubit extends Cubit<List<ProductBuy>> {
  AddItemCubit() : super([]);

  void addItem(ProductBuy item) {
    emit([...state, item]);
  }

  void removeItem(ProductBuy item) {
    emit(state.where((element) => element != item).toList());
  }

  void removeAllItem() {
    emit([]);
  }

  void reOrder2Items(int item1, int item2) {
    List<ProductBuy> newState = state;
    ProductBuy temp = newState[item1];
    newState[item1] = newState[item2];
    newState[item2] = temp;
    emit(newState);
  }
}