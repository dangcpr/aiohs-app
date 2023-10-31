import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';

class SaveAddressCubit extends Cubit<Address?> {
  SaveAddressCubit() : super(Address(name: "Nguyễn Hải Đăng", phone: "0123456789", address: "ABCXYZ", shortAddress:"ABCXYZ", typeOfAddress: 'Nhà riêng'));

  void setAddress(Address name) {
    emit(name);
  }
}