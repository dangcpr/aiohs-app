// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/delete_account/controllers/delete_account.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/login/views/login_page.dart';
import 'package:rmservice/utilities/constants/variable.dart';

void deleteAccountUser(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.bottomSlide,
    title: 'Bạn có chắc chắn muốn xóa tài khoản?',
    titleTextStyle: TextStyle(
      fontSize: fontSize.large,
      fontFamily: fontBoldApp,
      color: Colors.yellow.shade900,
    ),
    desc:
        'Bạn có chắc chắn muốn xóa tài khoản? Tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn và bạn không thể đăng nhập được như trước.',
    btnCancelOnPress: () {},
    btnOkOnPress: () async {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: colorProject.primaryColor,
            ),
          );
        },
      );
      try {
        await DeleteAccountController()
            .deleteAccount(context.read<UserCubit>().state.code!);
        await AuthenticationRepository()
            .logOut(context.read<UserCubit>().state.code!);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          title: 'Xóa tài khoản thành công',
          titleTextStyle: TextStyle(
              fontSize: fontSize.large,
              fontFamily: fontBoldApp,
              color: Colors.green),
          desc:
              'Tài khoản của bạn đã được xóa thành công. Nhấn OK để trở lại trang đăng nhập',
          btnOkOnPress: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: LoginPage(first_time: false),
              ),
              (route) => false,
            );
          },
        ).show();
      } catch (e) {
        Navigator.pop(context);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          title: 'Đã có lỗi xảy ra',
          titleTextStyle: TextStyle(
              fontSize: fontSize.large,
              fontFamily: fontBoldApp,
              color: Colors.red),
          desc: 'Vui lòng thử lại sau',
          btnOkOnPress: () {},
        ).show();
        return;
      }
    },
  ).show();
}
