import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cooking/model/cooking_price.dart';
import 'package:rmservice/cooking/model/info_cooking.dart';

class SaveInfoCookingCubit extends Cubit<InfoCooking> {
  SaveInfoCookingCubit()
      : super(InfoCooking(
            date: DateTime.now().add(Duration(days: 1)), time: DateTime.now()));

  void setInitial() {
    emit(InfoCooking(date: DateTime.now(), time: DateTime.now()));
  }

  void setInfoCleaningHourly(InfoCooking infoCooking) {
    emit(infoCooking);
  }

  int totalPrice(CookingPrice cookingPrice) {
    int totalPrice = 0;
    int totalFood = 0;
    if (state.food1 != "" &&
        state.food2 == "" &&
        state.food3 == "" &&
        state.food4 == "") totalFood = 1;

    if (state.food1 != "" &&
        state.food2 != "" &&
        state.food3 == "" &&
        state.food4 == "") totalFood = 2;

    if (state.food1 != "" &&
        state.food2 != "" &&
        state.food3 != "" &&
        state.food4 == "") totalFood = 3;

    if (state.food1 != "" &&
        state.food2 != "" &&
        state.food3 != "" &&
        state.food4 != "") totalFood = 4;

    totalPrice += cookingPrice.unitPrice * state.numberOfPeople * totalFood;
    emit(state);
    print('Total Price is: $totalPrice}');
    state.price = totalPrice;
    print('Total Price from model is: ${state.price}');
    emit(state);
    return totalPrice;
  }

  void updatePaymentMethod(String paymentMethod) {
    state.paymentMethod = paymentMethod;
    emit(state);
  }
}
