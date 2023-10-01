//File dùng để điều hướng màn hình
//Nếu đã vô app lần đầu => đăng nhập luôn
//Nếu chưa vô app => Tới màn hình Intro
//Nếu đã đăng nhập => Vô Main screen (cài đặt sau)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/views/login_screen.dart';
import 'package:rmservice/utilities/components/circle_indicator_screen.dart';
import 'package:rmservice/utilities/constants/function.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_cubit.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_state.dart';

class SetFirstTimeScreen extends StatefulWidget {
  const SetFirstTimeScreen({super.key});

  @override
  State<SetFirstTimeScreen> createState() => _SetFirstTimeScreenState();
}

class _SetFirstTimeScreenState extends State<SetFirstTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SetFirstTimeCubit, SetFirstTimeState>(
        builder: (context, state) {
          if (state is SetFirstTimeInitialState) {
            debugPrint('456');
            context.read<SetFirstTimeCubit>().setFirstTime();
            return CircleIndicatorScreen();
          }

          if (state is SetFirstTimeLoadingState) {
            return CircleIndicatorScreen();
          }

          if (state is SetFirstTimeLoadedState) {
            debugPrint(state.firstTime.toString());
            return LoginScreen(first_time: true,);
          }

          if (state is SetFirstTimeErrorState) {
            errorMessage(state.error, context);
            return LoginScreen(first_time: true,);
          }

          return CircleIndicatorScreen();
        },
      ),
    );
  }
}
