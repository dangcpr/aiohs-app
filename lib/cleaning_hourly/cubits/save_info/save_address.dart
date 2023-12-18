import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/user_address/models/address_response.dart';

class SaveAddressCubit extends Cubit<Address?> {
  SaveAddressCubit()
      : super(Address(
            name: "",
            phone: "",
            address: "",
            shortAddress: "",
            latitude: 0,
            longitude: 0,
            typeOfAddress: "Nhà riêng"));

  void setAddress(Address name) {
    emit(name);
  }

  void setAddressFromRes(AddressResponse address) {
    Address? newAddress = state;
    newAddress!.name = address.agent_name;
    newAddress.phone = address.agent_phone;
    newAddress.address = address.street_name;
    newAddress.shortAddress = address.detail;
    newAddress.latitude = address.latitude;
    newAddress.longitude = address.longitude;
    newAddress.typeOfAddress = address.type;
    emit(Address(
        name: "",
        phone: "",
        address: "",
        shortAddress: "",
        latitude: 0,
        longitude: 0,
        typeOfAddress: "Nhà riêng"));
    emit(newAddress);
  }

  void changeNamePhone(String name, String phone) {
    Address? newAddress = state;
    newAddress!.name = name;
    newAddress.phone = phone;
    emit(newAddress);
  }

  void setInit() {
    emit(Address(
        name: "",
        phone: "",
        address: "",
        shortAddress: "",
        latitude: 0,
        longitude: 0,
        typeOfAddress: "Nhà riêng"));
  }
}
