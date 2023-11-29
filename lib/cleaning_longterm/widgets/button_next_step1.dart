import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/views/air_conditioning_cleaning_screen_step2.dart';
import 'package:rmservice/cleaning_longterm/cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/cubit/price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';

import '../../air_conditioning_cleaning/views/air_conditioning_cleaning_sreen_step1.dart';
import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../utilities/components/dialog_wrong.dart';
import '../../utilities/constants/variable.dart';
import '../views/cleaning_longterm_screen_step2.dart';

class ButtonNextStep1 extends StatefulWidget {
  const ButtonNextStep1({super.key});

  @override
  State<ButtonNextStep1> createState() => _ButtonNextStep1State();
}

class _ButtonNextStep1State extends State<ButtonNextStep1> {
  int time6Hours = 6 * 60;
  int time23Hours = 23 * 60;
  NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');

  @override
  Widget build(BuildContext context) {
    var priceCleaningLongTerm =
        context.read<PriceCleaningLongTermCubit>().state;

    final time = context.read<SaveInfoCleaningLongTermCubit>().state.time;

    final price = context.read<SaveInfoCleaningLongTermCubit>().state.price;

    int timeToInt = time!.hour * 60 + time.minute;
    int duration =
        context.read<SaveInfoCleaningLongTermCubit>().state.realDuration;
    int timeEnd = time23Hours - duration * 60;

    debugPrint(timeToInt.toString() + ' ' + timeEnd.toString());
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: ButtonGreenApp(
        label: "Tiếp theo",
        onPressed: () async {
          if (context.read<SaveAddressCubit>().state == null ||
              context.read<SaveAddressCubit>().state!.address == "") {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                    notification: "Vui lòng chọn địa điểm làm việc",
                  );
                });
            return;
          }
          if (context.read<SaveInfoCleaningLongTermCubit>().state.days.length ==
              0) {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                    notification: "Vui lòng chọn ngày làm việc làm việc",
                  );
                });
            return;
          }
          if (await DatetimeSetting.timeIsAuto() == false ||
              await DatetimeSetting.timeZoneIsAuto() == false) {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                      notification:
                          "Vui lòng lựa chọn giờ và múi giờ tự động trên thiết bị");
                });
            return;
          }
          if (context.read<SaveInfoCleaningLongTermCubit>().state.time!.hour *
                          60 +
                      context
                          .read<SaveInfoCleaningLongTermCubit>()
                          .state
                          .time!
                          .minute <
                  time6Hours ||
              context.read<SaveInfoCleaningLongTermCubit>().state.time!.hour *
                          60 +
                      context
                          .read<SaveInfoCleaningLongTermCubit>()
                          .state
                          .time!
                          .minute >
                  time23Hours -
                      context
                              .read<SaveInfoCleaningLongTermCubit>()
                              .state
                              .duration *
                          60) {
            debugPrint("Vui lòng chọn giờ làm việc từ 06:00 tới " +
                (23 - duration).toString() +
                " giờ");
            showDialog(
              context: context,
              builder: (context) {
                return DialogWrong(
                    notification:
                        "Vui lòng chọn giờ làm việc từ 06:00 tới ${(23 - duration).toString()}:00");
              },
            );
            return;
          }
          context
              .read<SaveInfoCleaningLongTermCubit>()
              .totalPrice(priceCleaningLongTerm);
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: CleaningLongTermStep2(),
            ),
          );
        },
      ),
    );
  }
}
