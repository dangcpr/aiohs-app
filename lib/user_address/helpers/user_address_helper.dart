// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/user_address/controllers/user_address.dart';
import 'package:rmservice/user_address/cubits/get_user_address/get_user_address.dart';
import 'package:rmservice/user_address/models/address_response.dart';

class UserAddressHelper {
  Future<void> addAddressAndGetAddress(Address address, String userCode,
      bool isDefault, BuildContext context) async {
    await UserAddressController().addAddress(address, userCode, isDefault);
    List<AddressResponse> listAddress =
        await UserAddressController().getAddress(userCode);
    context.read<GetUserAddressCubit>().setListUserAddress(listAddress);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
