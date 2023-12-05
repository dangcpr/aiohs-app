// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_state.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step2.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step3.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var caculateCHPriceCubit =
        context.watch<CaculatePriceCleaningHourlyCubit>();

    //final date = context.read<SaveInfoCleaningHourlyCubit>().state.date;
    final time = context.read<SaveInfoCleaningHourlyCubit>().state.time;

    int timeToInt = time!.hour * 60 + time.minute;
    int duration =
        context.read<SaveInfoCleaningHourlyCubit>().state.realDuration!;
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
            numberFormat.format(caculateCHPriceCubit.priceTotal) +
                ' - ' +
                context
                    .read<SaveInfoCleaningHourlyCubit>()
                    .state
                    .realDuration
                    .toString() +
                " giờ",
            style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger + 1,
                color: colorProject.primaryColor),
          ),
          caculateCHPriceCubit.state is CaculatePriceCleaningHourlyLoading
              ? const ElevatedButton(
                  onPressed: null,
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.grey)))
              : caculateCHPriceCubit.state is CaculatePriceCleaningHourlyError
                  ? const ElevatedButton(
                      onPressed: null,
                      child: Text("Đã có lỗi xảy ra"),
                    )
                  : ButtonGreenApp(
                      label: AppLocalizations.of(context)!.nextLabel,
                      onPressed: () async {
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
                        if (context
                                            .read<SaveInfoCleaningHourlyCubit>()
                                            .state
                                            .time!
                                            .hour *
                                        60 +
                                    context
                                        .read<SaveInfoCleaningHourlyCubit>()
                                        .state
                                        .time!
                                        .minute <
                                time6Hours ||
                            context
                                            .read<SaveInfoCleaningHourlyCubit>()
                                            .state
                                            .time!
                                            .hour *
                                        60 +
                                    context
                                        .read<SaveInfoCleaningHourlyCubit>()
                                        .state
                                        .time!
                                        .minute >
                                time23Hours -
                                    context
                                            .read<SaveInfoCleaningHourlyCubit>()
                                            .state
                                            .realDuration! *
                                        60) {
                          debugPrint(
                              "Vui lòng chọn giờ làm việc từ 06:00 tới " +
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
                        context.read<SaveInfoCleaningHourlyCubit>().updatePrice(caculateCHPriceCubit.priceTotal);
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 400),
                            type: PageTransitionType.rightToLeftWithFade,
                            child: CleaningHourlyStep3Screen(),
                            childCurrent: CleaningHourlyStep2Screen(),
                          ),
                        );

                        debugPrint(context
                            .read<SaveInfoCleaningHourlyCubit>()
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
