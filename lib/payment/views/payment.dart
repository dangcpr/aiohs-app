import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, required this.money, required this.service});

  final String money;
  final String service;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
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
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
                "https://vnpay-aiohs.onrender.com/order/create_payment_url"),
            method: 'POST',
            body: Uint8List.fromList(
                utf8.encode("amount=${widget.money}&bankCode=&language=vn")),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
        onWebViewCreated: (controller) {
          debugPrint("Open web success");
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
                // ignore: use_build_context_synchronously
                context.read<OrderLaundryCubit>().orderLaundry(
                      // ignore: use_build_context_synchronously
                      context.read<SaveInfoLaundryCubit>().state,
                      // ignore: use_build_context_synchronously
                      context.read<SaveAddressCubit>().state!,
                      // ignore: use_build_context_synchronously
                      context.read<UserCubit>().state.code!,
                    );
                context.read<OrderLaundryCubit>().setInit();
              } else if (widget.service == 'CLEAN_ON_DEMAND') {
                // ignore: use_build_context_synchronously
                context.read<OrderCleaningHourlyCubit>().orderCleaningHourly(
                      // ignore: use_build_context_synchronously
                      context.read<SaveInfoCleaningHourlyCubit>().state,
                      // ignore: use_build_context_synchronously
                      context.read<SaveAddressCubit>().state!,
                      // ignore: use_build_context_synchronously
                      context.read<UserCubit>().state.code!,
                    );
              }
            } else {
              // ignore: use_build_context_synchronously
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
    );
  }
}
