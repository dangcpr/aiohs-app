// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/user_address/controllers/user_address.dart';
import 'package:rmservice/user_address/cubits/get_user_address/get_user_address.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/user_address/views/get_user_address.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class AccountHelper {
  void getUserAddress(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: colorProject.primaryColor),
        );
      },
    );
    try {
      List<AddressResponse> listAddress = await UserAddressController()
          .getAddress(context.read<UserCubit>().state.code!);
      context.read<GetUserAddressCubit>().setListUserAddress(listAddress);
      
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
          duration: Duration(milliseconds: 400),
          type: PageTransitionType.rightToLeftWithFade,
          child: GetUserAddressScreen(),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return DialogWrong(
            notification: e.toString(),
          );
        },
      );
      debugPrint(e.toString());
    }
  }
}
