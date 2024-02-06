// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/laundry/controllers/laundry.dart';
import 'package:rmservice/laundry/cubits/calculate_laundry/calculate_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/calculate_laundry/calculate_laundry_state.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/payment/controllers/zalopay.dart';
import 'package:rmservice/payment/models/zalopay.dart';
import 'package:rmservice/payment/views/payment.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/circle_idicator_dialog.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonNextStep3Laundry extends StatefulWidget {
  const ButtonNextStep3Laundry({super.key});

  @override
  State<ButtonNextStep3Laundry> createState() => _ButtonNextStep3LaundryState();
}

class _ButtonNextStep3LaundryState extends State<ButtonNextStep3Laundry> {
  late Timer timer;
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var infoLaundryCubit = context.watch<SaveInfoLaundryCubit>();
    var userCubit = context.watch<UserCubit>();
    var addressCubit = context.watch<SaveAddressCubit>();
    var calculateLaundry = context.watch<CalculateLaundryCubit>();

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
              formatter.format(calculateLaundry.totalPrice),
              style: TextStyle(
                fontSize: 20,
                fontFamily: fontBoldApp,
                color: colorProject.primaryColor,
              ),
            ),
          ),
          calculateLaundry.state is CalculateLaundryLoading
              ? const ElevatedButton(
                  onPressed: null,
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.grey)))
              : calculateLaundry.state is CalculateLaundryError
                  ? const ElevatedButton(
                      onPressed: null, child: Text("Đã có lỗi"))
                  : ButtonGreenApp(
                      label: AppLocalizations.of(context)!.nextLabel,
                      onPressed: () async {
                        if (infoLaundryCubit.state.paymentMethod ==
                            'PAYMENT_METHOD_CASH') {
                          infoLaundryCubit.updateTotalPrice(
                              context.read<CalculateLaundryCubit>().totalPrice);
                          context.read<OrderLaundryCubit>().orderLaundry(
                                infoLaundryCubit.state,
                                addressCubit.state!,
                                userCubit.state.code!,
                              );
                        } else if (infoLaundryCubit.state.paymentMethod ==
                            'PAYMENT_METHOD_WALLET') {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 400),
                              type: PageTransitionType.rightToLeftWithFade,
                              child: PayScreen(
                                money: infoLaundryCubit.state.totalPrice
                                    .toString(),
                                service: 'LAUNDRY',
                              ),
                            ),
                          );
                        }  else {
                debugPrint("Zalopay");
                showCircleIndicatorDialog(context);
                showCircleIndicatorDialog(context);
                try {
                  String orderCode = await LaundryController()
                      .orderLaundry(infoLaundryCubit.state, addressCubit.state!,
                          userCubit.state.code!);
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
                            Navigator.pop(context);
                          },
                        ).show();
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
