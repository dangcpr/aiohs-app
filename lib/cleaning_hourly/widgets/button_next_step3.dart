import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/payment/views/payment.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ButtonNextStep3 extends StatefulWidget {
  const ButtonNextStep3({super.key});

  @override
  State<ButtonNextStep3> createState() => _ButtonNextStep3State();
}

class _ButtonNextStep3State extends State<ButtonNextStep3> {
  Widget build(BuildContext context) {
    var infoCubit = context.watch<SaveInfoCleaningHourlyCubit>();
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
              formatter.format(context.read<CaculatePriceCleaningHourlyCubit>().priceTotal) + ' - ' + infoCubit.state.realDuration.toString() + " giờ",
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
              if(infoCubit.state.paymentMethod == 'PAYMENT_METHOD_CASH') {
                context.read<OrderCleaningHourlyCubit>().orderCleaningHourly(
                  infoCubit.state,
                  addressCubit.state!,
                  userCubit.state.code!,
                );
              }
              else {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: PayScreen(
                      money: infoCubit.state.price.toString(),
                      service: 'CLEAN_ON_DEMAND',
                    )
                  )
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
