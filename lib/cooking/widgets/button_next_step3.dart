// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step3.dart';
import 'package:rmservice/cleaning_hourly/views/complete.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/cooking/views/complete_screen.dart';
import 'package:rmservice/cooking/views/cooking_screen_step3.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:datetime_setting/datetime_setting.dart';

class ButtonNextStep3 extends StatefulWidget {
  const ButtonNextStep3({super.key});

  @override
  State<ButtonNextStep3> createState() => _ButtonNextStep3State();
}

class _ButtonNextStep3State extends State<ButtonNextStep3> {
  //final timeIsAuto = DatetimeSetting.timeIsAuto();
  //final timeZoneIsAuto = DatetimeSetting.timeZoneIsAuto();
  int time6Hours = 6 * 60;
  int time23Hours = 23 * 60;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonGreenApp(
            label: "Tiếp theo",
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: CompleteScreen(),
                  childCurrent: CookingScreenStep3(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
