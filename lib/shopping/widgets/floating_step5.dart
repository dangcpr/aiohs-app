import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/views/complete_shopping.dart';
import 'package:rmservice/shopping/views/shopping_step5.dart';
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
                .format(context.watch<SaveDataShopping>().state.price),
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger + 1,
              color: colorProject.primaryColor,
            ),
          ),
          ButtonGreenApp(
            label: AppLocalizations.of(context)!.nextLabel,
            onPressed: () async {

              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: CompleteShoppingScreen(),
                  childCurrent: ShoppingStep5Screen(),
                ),
              );


            },
          ),
        ],
      ),
    );
  }
}