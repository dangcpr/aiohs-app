import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/order_air_cond/order_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../login/cubit/user_cubit.dart';
import '../../payment/views/payment.dart';
import '../../utilities/components/button_green.dart';
import '../../utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonNextStep3 extends StatelessWidget {
  const ButtonNextStep3({super.key});

  @override
  Widget build(BuildContext context) {
    var infoCubit = context.watch<SaveInfoAirConditioningCleaningCubit>();
    var userCubit = context.watch<UserCubit>();
    var addressCubit = context.watch<SaveAddressCubit>();
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
              formatter.format(context
                      .read<SaveInfoAirConditioningCleaningCubit>()
                      .state
                      .price) +
                  ' - ' +
                  infoCubit.state.realDuration.toString() +
                  " giờ",
              style: TextStyle(
                fontSize: 20,
                fontFamily: fontBoldApp,
                color: colorProject.primaryColor,
              ),
            ),
          ),
          ButtonGreenApp(
            label: AppLocalizations.of(context)!.nextLabel,
            onPressed: () {
              if (infoCubit.state.paymentMethod == 'PAYMENT_METHOD_CASH') {
                context.read<OrderAirCondCubit>().orderAirCond(
                      infoCubit.state,
                      addressCubit.state!,
                      userCubit.state.code!,
                    );
              } else {
                Navigator.push(
                    context,
                    PageTransition(
                        duration: Duration(milliseconds: 400),
                        type: PageTransitionType.rightToLeftWithFade,
                        child: PayScreen(
                          money: infoCubit.state.price.toString(),
                          service: 'AIR_CONDITIONING',
                        )));
              }
            },
          ),
        ],
      ),
    );
  }
}
