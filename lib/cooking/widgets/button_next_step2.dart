// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step2.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step3.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/cooking/views/cooking_screen_step3.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/price_cooking_cubit.dart';
import '../views/cooking_screen_step2.dart';

class ButtonNextStep2 extends StatefulWidget {
  const ButtonNextStep2({super.key});

  @override
  State<ButtonNextStep2> createState() => _ButtonNextStep2State();
}

class _ButtonNextStep2State extends State<ButtonNextStep2> {
  //final timeIsAuto = DatetimeSetting.timeIsAuto();
  //final timeZoneIsAuto = DatetimeSetting.timeZoneIsAuto();
  int time6Hours = 6 * 60;
  int time23Hours = 23 * 60;

  @override
  Widget build(BuildContext context) {
    final date = context.read<SaveInfoCookingCubit>().state.date;
    final time = context.read<SaveInfoCookingCubit>().state.time;

    int timeToInt = time!.hour * 60 + time.minute;
    if (context.read<SaveInfoCookingCubit>().state.bonusService != 0) {
      context.read<SaveInfoCookingCubit>().state.realDuration = 2.5;
    } else {
      context.read<SaveInfoCookingCubit>().state.realDuration = 2;
    }
    double duration = context.read<SaveInfoCookingCubit>().state.realDuration;
    double timeEnd = time23Hours - duration * 60;

    debugPrint(timeToInt.toString() + ' ' + timeEnd.toString());

    var infoCubit = context.watch<SaveInfoCookingCubit>();

    var cleaningLongTermPrice = context.read<CookingPriceCubit>().state;

    var totalPrice = infoCubit.totalPrice(cleaningLongTermPrice);

    final formatter = NumberFormat.simpleCurrency(locale: "vi-VN");

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
            formatter.format(infoCubit.state.price) +
                ' - ' +
                '${infoCubit.state.duration} Giờ',
            style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger + 1,
                color: colorProject.primaryColor),
          ),
          ButtonGreenApp(
            label: AppLocalizations.of(context)!.nextLabel,
            onPressed: () async {
              if (Platform.isAndroid && (await DatetimeSetting.timeIsAuto() == false ||
                  await DatetimeSetting.timeZoneIsAuto() == false)) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWrong(
                          notification:
                              "Vui lòng lựa chọn giờ và múi giờ tự động trên thiết bị");
                    });
                return;
              }
              if (context.read<SaveInfoCookingCubit>().state.time!.hour * 60 +
                          context
                              .read<SaveInfoCookingCubit>()
                              .state
                              .time!
                              .minute <
                      time6Hours ||
                  context.read<SaveInfoCookingCubit>().state.time!.hour * 60 +
                          context
                              .read<SaveInfoCookingCubit>()
                              .state
                              .time!
                              .minute >
                      time23Hours -
                          context
                                  .read<SaveInfoCleaningHourlyCubit>()
                                  .state
                                  .realDuration! *
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
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: CookingScreenStep3(),
                  childCurrent: CookingScreenStep2(),
                ),
              );

              debugPrint(context
                  .read<SaveInfoCookingCubit>()
                  .state
                  .toJson()
                  .toString());
            },
          ),
        ],
      ),
    );
  }
}
