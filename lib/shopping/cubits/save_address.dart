import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/models/address_shopping.dart';

class SaveAddressShoppingCubit extends Cubit<AddressShopping?> {
  SaveAddressShoppingCubit() : super(AddressShopping());

  void setAddress(AddressShopping name) {
    emit(name);
  }
  void setNamePhone(String name, String phone) {
    AddressShopping? newState = state;
    newState!.yourName = name;
    newState.phoneNum = phone;
    emit(newState);
  }
  void setInit() {
    emit(AddressShopping());
  }
}