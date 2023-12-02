// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cooking/cubit/order_cooking/order_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/price_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../login/cubit/user_cubit.dart';
import '../../payment/views/payment.dart';

class ButtonNextStep3 extends StatefulWidget {
  const ButtonNextStep3({super.key});

  @override
  State<ButtonNextStep3> createState() => _ButtonNextStep3State();
}

class _ButtonNextStep3State extends State<ButtonNextStep3> {
  @override
  Widget build(BuildContext context) {
    var infoCubit = context.watch<SaveInfoCookingCubit>();
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
              formatter.format(infoCubit.state.price) +
                  ' - ' +
                  '${infoCubit.state.duration} Giờ',
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
                context.read<OrderCookingCubit>().orderCooking(
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
                          service: 'HOME_COOKING',
                        )));
              }
            },
          ),
        ],
      ),
    );
  }
}
