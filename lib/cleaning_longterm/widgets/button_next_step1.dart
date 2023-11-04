import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step1.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step2.dart';
import 'package:rmservice/cleaning_hourly/widgets/dialog_wrong.dart';
import 'package:rmservice/cleaning_longterm/cleaning_longterm.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../views/cleaning_longterm_screen_step2.dart';

class ButtonNextStep1 extends StatefulWidget {
  const ButtonNextStep1({super.key});

  @override
  State<ButtonNextStep1> createState() => _ButtonNextStep1State();
}

class _ButtonNextStep1State extends State<ButtonNextStep1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: ButtonGreenApp(
        label: "Tiếp theo",
        onPressed: () {
          /*
          if (context.read<SaveInfoCleaningHourlyCubit>().state.location ==
              null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 50,
                  ),
                  content: Text(
                    textAlign: TextAlign.center,
                    "Bạn chưa chọn địa điểm",
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.mediumLarger,
                    )
                  ),
                );
              },
            );
            return;
          }
          */
          int cooking =
              context.read<SaveInfoCleaningHourlyCubit>().state.cooking! == true
                  ? 1
                  : 0;
          int iron =
              context.read<SaveInfoCleaningHourlyCubit>().state.iron! == true
                  ? 1
                  : 0;
          context.read<SaveInfoCleaningHourlyCubit>().state.realDuration =
              context.read<SaveInfoCleaningHourlyCubit>().state.duration! +
                  cooking +
                  iron;
          if (context.read<SaveInfoCleaningHourlyCubit>().state.realDuration! >
              4) {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                    notification:
                        "Tổng thời gian làm tính cả dịch vụ gia tăng là " +
                            context
                                .read<SaveInfoCleaningHourlyCubit>()
                                .state
                                .realDuration
                                .toString() +
                            " giờ. Vui lòng lựa chọn lại sao cho thời gian làm dưới 4 giờ",
                  );
                });
            return;
          }
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: CleaningLongTermStep2(),
              childCurrent: CleaningLongTermStep1(),
            ),
          );
        },
      ),
    );
  }
}
