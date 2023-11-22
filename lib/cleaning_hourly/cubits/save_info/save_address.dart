import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';

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
