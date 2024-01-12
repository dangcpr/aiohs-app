import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/payment/views/payment.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/shopping/cubits/order_shopping/order_shopping_cubit.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FloatingStep5 extends StatefulWidget {
  const FloatingStep5({super.key});

  @override
  State<FloatingStep5> createState() => _FloatingStep5State();
}

class _FloatingStep5State extends State<FloatingStep5> {
  @override
  Widget build(BuildContext context) {
    final saveDataShopping = context.read<SaveDataShopping>().state;
    final addressShopping = context.read<SaveAddressShoppingCubit>().state;
    final userCode = context.read<UserCubit>().state.code;
    var caculateSPriceCubit = context.watch<CalculatePriceShoppingCubit>();

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
            NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                .format(
                    caculateSPriceCubit.priceTotal),
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger + 1,
              color: colorProject.primaryColor,
            ),
          ),
          ButtonGreenApp(
            label: AppLocalizations.of(context)!.nextLabel,
            onPressed: () async {
              if (saveDataShopping.paymentMethod == 'PAYMENT_METHOD_CASH') {
                saveDataShopping.price = caculateSPriceCubit.priceTotal;
                context.read<OrderShoppingCubit>().orderShopping(
                    saveDataShopping, addressShopping!, userCode!);
              } else {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: PayScreen(
                      money: (caculateSPriceCubit.priceTotal)
                          .toString(),
                      service: 'GROCERY_ASSISTANT',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
