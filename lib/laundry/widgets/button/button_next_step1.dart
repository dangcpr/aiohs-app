import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/views/laundry_step2.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonNextStep1Laundry extends StatefulWidget {
  const ButtonNextStep1Laundry({super.key});

  @override
  State<ButtonNextStep1Laundry> createState() => _ButtonNextStep1LaundryState();
}

class _ButtonNextStep1LaundryState extends State<ButtonNextStep1Laundry> {
  @override
  Widget build(BuildContext context) {
    var infoLaundryCubit = context.watch<SaveInfoLaundryCubit>();
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

          if (infoLaundryCubit.state.totalPrice == 0) {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                    notification: "Vui lòng chọn ít nhất một thứ bạn muốn giặt ủi",
                  );
                });
            return;
          }
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 400),
              type: PageTransitionType.rightToLeftWithFade,
              child: LaundryStep2Screen(),
            ),
          );
        },
      ),
    );
  }
}
