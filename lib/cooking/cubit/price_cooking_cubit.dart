import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cooking/model/cooking_price.dart';

class CookingPriceCubit extends Cubit<CookingPrice> {
  CookingPriceCubit() : super(CookingPrice());

  void setPriceCleaningHourly(CookingPrice cookingPrice) {
    emit(cookingPrice);
  }
}
