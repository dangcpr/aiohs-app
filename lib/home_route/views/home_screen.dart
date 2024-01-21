//File dùng để điều hướng màn hình
//Nếu đã vô app lần đầu => đăng nhập luôn
//Nếu chưa vô app => Tới màn hình Intro
//Nếu đã đăng nhập => Vô Main screen (cài đặt sau)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/authentication_repository/authentication_repository.dart';
import 'package:rmservice/home_page/home_page.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/circle_indicator_screen.dart';
import 'package:rmservice/utilities/constants/function.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_state.dart';
import 'package:rmservice/home_route/views/intro_screen/intro_screen.dart';

import '../../login/views/login_page.dart';
import '../../network/cubit/network_cubit.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit()..checkConnection(),
      child: Scaffold(
        body: BlocBuilder<GetFirstTimeCubit, GetFirstTimeState>(
          builder: (context, state) {
            if (state is GetFirstTimeInitialState) {
              debugPrint('123');
              context.read<GetFirstTimeCubit>().getFirstTime();
              return CircleIndicatorScreen();
            }

            if (state is GetFirstTimeLoadingState) {
              return CircleIndicatorScreen();
            }

            if (state is GetFirstTimeLoadedState) {
              if (state.firstTime == true) {
                return IntroScreenApp();
              } else {
                if(state.loginModel.status != AuthenticationStatus.authenticated){
                  return LoginPage(first_time: false);
                } else {
                  debugPrint("456");
                  context.read<UserCubit>().setUser(state.loginModel.user!);
                  //debugPrint(state.loginModel.user!.code.toString());
                  return HomePage();
                }
              }
            }

            if (state is GetFirstTimeErrorState) {
              errorMessage(state.error, context);
              return LoginPage(first_time: false);
            }

            return CircleIndicatorScreen();
          },
        ),
      ),
    );
  }
}
