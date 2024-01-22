// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/account/cubits/logout/logout_cubit.dart';
import 'package:rmservice/change_password/views/change_pass_page.dart';
import 'package:rmservice/login/cubit/login_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/login/views/login_page.dart';
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

  void changePassword(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        duration: Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeftWithFade,
        child: ChangePassPage(),
      ),
    );
  }

  void logOut(BuildContext context, String userCode) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: colorProject.primaryColor),
        );
      },
    );
    try {
      await context.read<LogoutCubit>().logout(userCode);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        PageTransition(
          duration: Duration(milliseconds: 400),
          type: PageTransitionType.rightToLeftWithFade,
          child: LoginPage(first_time: false),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Đăng xuất thất bại',
        desc: e.toString(),
        btnOkOnPress: () {},
      ).show();
      debugPrint(e.toString());
      context.read<LoginCubit>().setInit();
    }
  }
}
