//File dùng để điều hướng màn hình
//Nếu đã vô app lần đầu => đăng nhập luôn
//Nếu chưa vô app => Tới màn hình Intro
//Nếu đã đăng nhập => Vô Main screen (cài đặt sau)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/components/circle_indicator_screen.dart';
import 'package:rmservice/constants/function.dart';
import 'package:rmservice/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/cubits/get_first_time/get_first_time_state.dart';
import 'package:rmservice/views/auth/login_screen.dart';
import 'package:rmservice/views/auth/signup_screen.dart';
import 'package:rmservice/views/intro_screen/intro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return SignupScreen(first_time: false);
            }
          }

          if (state is GetFirstTimeErrorState) {
            errorMessage(state.error, context);
            return LoginScreen(title: 'SnS', first_time: false);
          }

          return CircleIndicatorScreen();
        },
      ),
    );
  }
}
