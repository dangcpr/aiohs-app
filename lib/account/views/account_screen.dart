import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/account/helpers/account.dart';
import 'package:rmservice/account/widgets/info_account.dart';
import 'package:rmservice/account/widgets/option_card.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/profile/profile.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        InfoAccount(),
        SizedBox(height: 20),
        OptionCard(
          text: "Chỉnh sửa thông tin",
          icon: Icons.change_circle,
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: ProfilePage(),
              ),
            );
          },
        ),
        OptionCard(
          text: "Đổi mật khẩu",
          icon: Icons.password,
          onTap: () {
            AccountHelper().changePassword(context);
          },
        ),
        OptionCard(
          text: "Địa chỉ đã lưu",
          icon: Icons.location_on,
          onTap: () async {
            AccountHelper().getUserAddress(context);
          },
        ),
        OptionCard(
          text: "Đăng xuất",
          icon: Icons.logout,
          onTap: () {
            AccountHelper()
                .logOut(context, context.read<UserCubit>().state.code!);
          },
        ),
      ],
    );
  }
}
