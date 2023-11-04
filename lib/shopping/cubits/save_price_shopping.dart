import 'package:flutter_bloc/flutter_bloc.dart';

class SavePriceShopping extends Cubit<int> {
  SavePriceShopping() : super(0);

  void savePrice(int price) {
    emit(price);
  }
}