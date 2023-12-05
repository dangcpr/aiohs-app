import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/user_address/models/address_response.dart';

class GetUserAddressCubit extends Cubit<List<AddressResponse>> {
  GetUserAddressCubit() : super([]);

  void setListUserAddress(List<AddressResponse> listAddress) {
    emit(listAddress);
  }
}