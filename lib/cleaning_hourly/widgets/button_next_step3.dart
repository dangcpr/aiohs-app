// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step3.dart';
import 'package:rmservice/cleaning_hourly/views/complete.dart';
import 'package:rmservice/cleaning_hourly/widgets/dialog_wrong.dart';
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
    final date = context.read<SaveInfoCleaningHourlyCubit>().state.date;
    final time = context.read<SaveInfoCleaningHourlyCubit>().state.time;

    int timeToInt = time!.hour * 60 + time.minute;
    int duration = context.read<SaveInfoCleaningHourlyCubit>().state.realDuration!;
    int timeEnd = time23Hours - duration * 60;

    debugPrint(timeToInt.toString() + ' ' + timeEnd.toString());

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
          Text(
            "200.000" + " VNĐ - " + context.read<SaveInfoCleaningHourlyCubit>().state.realDuration.toString() + " giờ",
            style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger + 1,
                color: colorProject.primaryColor),
          ),
          ButtonGreenApp(
            label: "Tiếp theo",
            onPressed: () async {
              if (await DatetimeSetting.timeIsAuto() == false ||
                  await DatetimeSetting.timeZoneIsAuto() == false) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(notification: "Vui lòng lựa chọn giờ và múi giờ tự động trên thiết bị");
                  }
                );
                return;
              }
              if( context.read<SaveInfoCleaningHourlyCubit>().state.time!.hour * 60 + context.read<SaveInfoCleaningHourlyCubit>().state.time!.minute < time6Hours 
              || context.read<SaveInfoCleaningHourlyCubit>().state.time!.hour * 60 + context.read<SaveInfoCleaningHourlyCubit>().state.time!.minute > time23Hours - context.read<SaveInfoCleaningHourlyCubit>().state.realDuration! * 60){
                debugPrint("Vui lòng chọn giờ làm việc từ 06:00 tới " + (23 - duration).toString() + " giờ");
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(notification: "Vui lòng chọn giờ làm việc từ 06:00 tới ${(23 - duration).toString()}:00");
                  },
                );
                return;
              }
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: CompleteCleaningHourlyScreen(),
                  childCurrent: CleaningHourlyStep3Screen(),
                ),
              );

              debugPrint(context.read<SaveInfoCleaningHourlyCubit>().state.toJson().toString());
            },
          ),
        ],
      ),
    );
  }
}
