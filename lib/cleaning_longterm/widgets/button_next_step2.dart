// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/cubits/total_price_CH.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step2.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step3.dart';
import 'package:rmservice/cleaning_longterm/cubit/order_cleaning_longterm/order_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/cleaning_longterm/model/price_cleaning_longterm.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../login/cubit/user_cubit.dart';
import '../../payment/views/payment.dart';

class ButtonNextStep2 extends StatefulWidget {
  const ButtonNextStep2({super.key});

  @override
  State<ButtonNextStep2> createState() => _ButtonNextStep2State();
}

class _ButtonNextStep2State extends State<ButtonNextStep2> {
  @override
  Widget build(BuildContext context) {
    var infoCubit = context.watch<SaveInfoCleaningLongTermCubit>();
    var userCubit = context.watch<UserCubit>();
    var addressCubit = context.watch<SaveAddressCubit>();

    final formatter = NumberFormat.simpleCurrency(locale: "vi-VN");
    var cleaningLongTermPrice =
        context.read<PriceCleaningLongTermCubit>().state;

    var totalPrice = infoCubit.totalPrice(cleaningLongTermPrice);

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
              formatter.format(totalPrice) +
                  ' - ' +
                  '${infoCubit.state.days.length * infoCubit.state.month * 4} Buổi',
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
                context
                    .read<OrderCleaningLongtermCubit>()
                    .orderCleaningLongTerm(
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
                          service: 'CLEAN_LONG_TERM',
                        )));
              }
            },
          ),
        ],
      ),
    );
  }
}
