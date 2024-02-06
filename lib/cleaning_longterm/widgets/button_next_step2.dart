// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_longterm/cubit/cal_price/cal_price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/order_cleaning_longterm/order_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/cleaning_longterm/repo/cleaning_longterm_repo.dart';
import 'package:rmservice/payment/controllers/zalopay.dart';
import 'package:rmservice/payment/models/zalopay.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/circle_idicator_dialog.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../login/cubit/user_cubit.dart';
import '../../payment/views/payment.dart';

class ButtonNextStep2 extends StatefulWidget {
  const ButtonNextStep2({super.key});

  @override
  State<ButtonNextStep2> createState() => _ButtonNextStep2State();
}

class _ButtonNextStep2State extends State<ButtonNextStep2> {
  late Timer timer;
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
            child: BlocBuilder<CalPriceCleaningLongtermCubit,
                CalPriceCleaningLongtermState>(
              builder: (context, state) {
                if (state is CalPriceCleaningLongtermLoading) {
                  return Align(
                    alignment: Alignment.bottomLeft,
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CalPriceCleaningLongtermFailed) {
                  return Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontBoldApp,
                      color: colorProject.primaryColor,
                    ),
                  );
                }
                if (state is CalPriceCleaningLongtermSuccess) {
                  return Text(
                    formatter.format(state.totalPrice) +
                        ' - ' +
                        '${infoCubit.state.days.length * infoCubit.state.month * 4} Buổi',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontBoldApp,
                      color: colorProject.primaryColor,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          ButtonGreenApp(
            label: AppLocalizations.of(context)!.nextLabel,
            onPressed: () async {
              if (infoCubit.state.paymentMethod == 'PAYMENT_METHOD_CASH') {
                context
                    .read<OrderCleaningLongtermCubit>()
                    .orderCleaningLongTerm(
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
                    ),
                  ),
                );
              } else {
                debugPrint("Zalopay");
                showCircleIndicatorDialog(context);
                showCircleIndicatorDialog(context);
                try {
                  String orderCode = await CleaningLongTermRepo()
                      .orderCleaningLongTerm(infoCubit.state,
                          addressCubit.state!, userCubit.state.code!);
                  Zalopay zalopay = await ZalopayController().createOrder(
                    userCode: context.read<UserCubit>().state.code!,
                    orderCode: orderCode,
                  );
                  if (await canLaunchUrl(Uri.parse(zalopay.payment_url))) {
                    await launchUrl(Uri.parse(zalopay.payment_url));
                    timer =
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
