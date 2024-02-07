// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/order_air_cond/order_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_longterm/cubit/order_cleaning_longterm/order_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/cooking/cubit/order_cooking/order_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../shopping/cubits/order_shopping/order_shopping_cubit.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.money, required this.service});

  final String money;
  final String service;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pay Screen",
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            fontFamily: fontBoldApp,
          ),
        ),
      ),
      body: Column(
        children: [
          if (progress < 100)
            LinearProgressIndicator(
              value: progress / 100,
              color: colorProject.primaryColor,
            ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "http://18.143.167.78:8888/order/create_payment_url"),
                  method: 'POST',
                  body: Uint8List.fromList(utf8.encode("amount=${widget.money}&bankCode=&language=vn")),
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                  }),
              onWebViewCreated: (controller) {
                debugPrint("Open web success");
              },
              onProgressChanged: (controller, progress) {
                debugPrint("progress: $progress");
                setState(() {
                  this.progress = progress / 1;
                });
              },
              onLoadStop: (controller, url) async {
                if (url.toString().contains("/order/vnpay_return")) {
                  var response = await controller.evaluateJavascript(
                      source: 'document.body.innerText');
                  var code = jsonDecode(response)['code'];
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ResultScreen(result: code)));
                  // debugPrint(code);
                  if (code == "00") {
                    if (widget.service == 'LAUNDRY') {
                      context.read<OrderLaundryCubit>().orderLaundry(
                            context.read<SaveInfoLaundryCubit>().state,
                            context.read<SaveAddressCubit>().state!,
                            context.read<UserCubit>().state.code!,
                          );
                      context.read<OrderLaundryCubit>().setInit();
                    } else if (widget.service == 'CLEAN_ON_DEMAND') {
                      context
                          .read<OrderCleaningHourlyCubit>()
                          .orderCleaningHourly(
                            context.read<SaveInfoCleaningHourlyCubit>().state,
                            context.read<SaveAddressCubit>().state!,
                            context.read<UserCubit>().state.code!,
                          );
                    } else if (widget.service == 'GROCERY_ASSISTANT') {
                      context.read<SaveDataShopping>().state.price = context.read<CalculatePriceShoppingCubit>().priceTotal;
                      context.read<OrderShoppingCubit>().orderShopping(
                            context.read<SaveDataShopping>().state,
                            context.read<SaveAddressShoppingCubit>().state!,
                            context.read<UserCubit>().state.code!,
                          );
                    } else if (widget.service == 'CLEAN_LONG_TERM') {
                      context
                          .read<OrderCleaningLongtermCubit>()
                          .orderCleaningLongTerm(
                            context.read<SaveInfoCleaningLongTermCubit>().state,
                            context.read<SaveAddressCubit>().state!,
                            context.read<UserCubit>().state.code!,
                          );
                    } else if (widget.service == 'AIR_CONDITIONING') {
                      context.read<OrderAirCondCubit>().orderAirCond(
                            context
                                .read<SaveInfoAirConditioningCleaningCubit>()
                                .state,
                            context.read<SaveAddressCubit>().state!,
                            context.read<UserCubit>().state.code!,
                          );
                    } else if (widget.service == 'HOME_COOKING') {
                      context.read<OrderCookingCubit>().orderCooking(
                            context.read<SaveInfoCookingCubit>().state,
                            context.read<SaveAddressCubit>().state!,
                            context.read<UserCubit>().state.code!,
                          );
                    }
                  } else {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWrong(
                          notification: "Thanh toán thất bại. Vui lòng thử lại",
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
