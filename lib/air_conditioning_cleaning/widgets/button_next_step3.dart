// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/order_air_cond/order_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/repo/air_conditioning_cleaning_repo.dart';
import 'package:rmservice/payment/controllers/zalopay.dart';
import 'package:rmservice/payment/models/zalopay.dart';
import 'package:rmservice/utilities/components/circle_idicator_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onPressed: () async {
              if (infoCubit.state.paymentMethod == 'PAYMENT_METHOD_CASH') {
                context.read<OrderAirCondCubit>().orderAirCond(
                      infoCubit.state,
                      addressCubit.state!,
                      userCubit.state.code!,
                    );
              } else if (infoCubit.state.paymentMethod ==
                  'PAYMENT_METHOD_WALLET') {
                Navigator.push(
                    context,
                    PageTransition(
                        duration: Duration(milliseconds: 400),
                        type: PageTransitionType.rightToLeftWithFade,
                        child: PayScreen(
                          money: infoCubit.state.price.toString(),
                          service: 'AIR_CONDITIONING',
                        )));
              } else {
                debugPrint("Zalopay");
                showCircleIndicatorDialog(context);
                showCircleIndicatorDialog(context);
                try {
                  String orderCode = await AirCondRepo().orderAirCond(
                      infoCubit.state,
                      addressCubit.state!,
                      userCubit.state.code!);
                  Zalopay zalopay = await ZalopayController().createOrder(
                    userCode: context.read<UserCubit>().state.code!,
                    orderCode: orderCode,
                  );
                  if (await canLaunchUrl(Uri.parse(zalopay.payment_url))) {
                    await launchUrl(Uri.parse(zalopay.payment_url));
                    var timer =
                        Timer.periodic(Duration(seconds: 15), (Timer t) async {
                      debugPrint("Verify order");
                      int result = await ZalopayController().verifyOrder(
                          userCode: context.read<UserCubit>().state.code!,
                          refID: zalopay.ref_id);
                      if (result == 1) {
                        t.cancel();
                        Navigator.pop(context);
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            title: "Thanh toán thành công",
                            btnOkOnPress: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }).show();
                      }
                    });
                    Navigator.pop(context);
                  } else {
                    throw 'Could not launch ${zalopay.payment_url}';
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
