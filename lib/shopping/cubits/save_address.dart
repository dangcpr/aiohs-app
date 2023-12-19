import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/models/address_shopping.dart';
import 'package:rmservice/user_address/models/address_response.dart';

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

  void setAddressFromRes(AddressResponse address) {
    AddressShopping? newAddress = state;
    newAddress!.yourName = address.agent_name;
    newAddress.phoneNum = address.agent_phone;
    newAddress.fullAddress = address.street_name;
    newAddress.nameAddress = address.detail;
    newAddress.latCurrent = address.latitude;
    newAddress.lngCurrent = address.longitude;
    emit(AddressShopping());
    emit(newAddress);
  }

  void setOld() {
    emit(state);
  }

  void setInit() {
    emit(AddressShopping());
  }
}
