import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/views/air_conditioning_cleaning_screen_step2.dart';
import 'package:rmservice/air_conditioning_cleaning/views/air_conditioning_cleaning_sreen_step1.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step1.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step2.dart';
import 'package:rmservice/cleaning_hourly/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        label: AppLocalizations.of(context)!.nextLabel,
        onPressed: () {
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
          if (context
                  .read<SaveInfoAirConditioningCleaningCubit>()
                  .state
                  .details
                  .length ==
              0) {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                    notification: "Vui lòng chọn loại máy lạnh và số lượng",
                  );
                });
            return;
          }
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 400),
              type: PageTransitionType.rightToLeftWithFade,
              child: AirConditioningCleaningScreenStep2(),
              childCurrent: AirConditioningCleaningScreenStep1(),
            ),
          );
        },
      ),
    );
  }
}
