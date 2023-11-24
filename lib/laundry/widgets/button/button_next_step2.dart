import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/update_price_laundry_cubit.dart';
import 'package:rmservice/laundry/views/laundry_step3.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ButtonNextStep2Laundry extends StatefulWidget {
  const ButtonNextStep2Laundry({super.key});

  @override
  State<ButtonNextStep2Laundry> createState() => _ButtonNextStep2LaundryState();
}

class _ButtonNextStep2LaundryState extends State<ButtonNextStep2Laundry> {
  @override
  Widget build(BuildContext context) {
    var infoLaundryCubit = context.watch<SaveInfoLaundryCubit>();
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int time7Hours = 7 * 60;
    int time22Hours = 22 * 60;

    final formatter = NumberFormat.simpleCurrency(locale: "vi-VN");
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              formatter.format(context.watch<UpdatePriceLaundryCubit>().state),
              style: TextStyle(
                fontSize: 20,
                fontFamily: fontBoldApp,
                color: colorProject.primaryColor,
              ),
            ),
          ),
          ButtonGreenApp(
            label: AppLocalizations.of(context)!.nextLabel,
            onPressed: () async {
              if (await DatetimeSetting.timeIsAuto() == false ||
                  await DatetimeSetting.timeZoneIsAuto() == false) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(
                      notification:
                          "Vui lòng lựa chọn giờ và múi giờ tự động trên thiết bị",
                    );
                  },
                );
                return;
              }
              if (infoLaundryCubit.state.sendTime!.hour * 60 +
                          infoLaundryCubit.state.sendTime!.minute <
                      time7Hours ||
                  infoLaundryCubit.state.sendTime!.hour * 60 +
                          infoLaundryCubit.state.sendTime!.minute >
                      time22Hours) {
                debugPrint("Vui lòng chọn giờ nhận đồ từ 07:00 tới " +
                    (22).toString() +
                    " giờ");
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(
                      notification:
                          "Vui lòng chọn giờ nhận đồ từ 07:00 tới ${(22).toString()}:00",
                    );
                  },
                );
                return;
              }
              if (infoLaundryCubit.state.receiveTime!.hour * 60 +
                          infoLaundryCubit.state.receiveTime!.minute <
                      time7Hours ||
                  infoLaundryCubit.state.receiveTime!.hour * 60 +
                          infoLaundryCubit.state.receiveTime!.minute >
                      time22Hours) {
                debugPrint("Vui lòng chọn giờ trả đồ từ 07:00 tới " +
                    (22).toString() +
                    " giờ");
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(
                      notification:
                          "Vui lòng chọn giờ trả đồ từ 07:00 tới ${(22).toString()}:00",
                    );
                  },
                );
              }
              DateTime dateTimeSend = DateTime(
                  infoLaundryCubit.state.sendDate!.year,
                  infoLaundryCubit.state.sendDate!.month,
                  infoLaundryCubit.state.sendDate!.day,
                  infoLaundryCubit.state.sendTime!.hour,
                  infoLaundryCubit.state.sendTime!.minute,
                  0);
              DateTime dateTimeReceive = DateTime(
                  infoLaundryCubit.state.receiveDate!.year,
                  infoLaundryCubit.state.receiveDate!.month,
                  infoLaundryCubit.state.receiveDate!.day,
                  infoLaundryCubit.state.receiveTime!.hour,
                  infoLaundryCubit.state.receiveTime!.minute,
                  0);

              debugPrint('dateTimeSend: ' + dateTimeSend.toString());
              debugPrint('dateTimeSend: ' + dateTimeReceive.toString());

              if (dateTimeSend.isAfter(dateTimeReceive)) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWrong(
                        notification:
                            "Vui lòng chọn giờ trả đồ sau giờ nhận đồ",
                      );
                    });
                return;
              }
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: LaundryStep3Screen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
