import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/models/info_shopping.dart';

class SaveDataShopping extends Cubit<InfoShopping> {
  SaveDataShopping() : super(InfoShopping(date: DateTime.now().add(Duration(days: 1)), time: DateTime.now()));

  void updatePaymentMethod(String paymentMethod) {
    InfoShopping newState = state;
    newState.paymentMethod = paymentMethod;
    emit(newState);
  }

  void setItems(List<String> items) {
    InfoShopping newState = state;
    newState.listItems = items;
    emit(newState);
  }

  void setPurchaseFee(int purchaseFee) {
    InfoShopping newState = state;
    newState.purchaseFee = purchaseFee;
    emit(newState);
  }
}