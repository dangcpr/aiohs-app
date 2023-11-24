import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/update_price_laundry_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/payment/views/payment.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ButtonNextStep3Laundry extends StatefulWidget {
  const ButtonNextStep3Laundry({super.key});

  @override
  State<ButtonNextStep3Laundry> createState() => _ButtonNextStep3LaundryState();
}

class _ButtonNextStep3LaundryState extends State<ButtonNextStep3Laundry> {
  @override
  Widget build(BuildContext context) {
    var infoLaundryCubit = context.watch<SaveInfoLaundryCubit>();
    var userCubit = context.watch<UserCubit>();
    var addressCubit = context.watch<SaveAddressCubit>();
    
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
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
            onPressed: () {
              if(infoLaundryCubit.state.paymentMethod == 'PAYMENT_METHOD_CASH') {
                context.read<OrderLaundryCubit>().orderLaundry(
                  infoLaundryCubit.state,
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
                      money: infoLaundryCubit.state.totalPrice.toString(),
                      service: 'LAUNDRY',
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