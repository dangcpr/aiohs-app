import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/models/shopping_price.dart';

class ShoppingPriceCubit extends Cubit<ShoppingPrice> {
  ShoppingPriceCubit() : super(ShoppingPrice());

  void setPrice(ShoppingPrice price) {
    emit(price);
  }
}