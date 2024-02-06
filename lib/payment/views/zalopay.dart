// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/payment/controllers/zalopay.dart';
import 'package:rmservice/payment/models/zalopay.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:url_launcher/url_launcher.dart';

class ZalopayScreen extends StatefulWidget {
  const ZalopayScreen(
      {super.key, required this.orderCode, required this.service});

  final String orderCode;
  final String service;

  @override
  State<ZalopayScreen> createState() => _ZalopayScreenState();
}

class _ZalopayScreenState extends State<ZalopayScreen> {
  double progress = 0;
  String paymentUrl = "";
  var getPaymentUrlBuilder = Future.value(Zalopay());
  @override
  void initState() {
    super.initState();
    getPaymentUrlBuilder = getPaymentUrl();
  }

  Future<Zalopay> getPaymentUrl() {
    return ZalopayController().createOrder(
      userCode: context.read<UserCubit>().state.code!,
      orderCode: widget.orderCode,
    );
  }

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
      body: FutureBuilder(
        future: getPaymentUrlBuilder,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                if (progress < 100)
                  LinearProgressIndicator(
                    value: progress / 100,
                    color: colorProject.primaryColor,
                  ),
                Expanded(
                  child: InAppWebView(
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useShouldOverrideUrlLoading: true,
                        resourceCustomSchemes: ["zalopay"],
                      ),
                    ),
                    onLoadResourceCustomScheme: (controller, url) async {
                      if (url.toString().contains("zalopay")) {
                        debugPrint("Open zalopay success");
                        await launchUrl(url);
                      } else {
                        debugPrint("Open web success");
                      }
                      return null;
                    },
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(snapshot.data!.payment_url),
                      // method: 'GET',
                      // body: Uint8List.fromList(utf8.encode(
                      //     "amount=${widget.money}&bankCode=&language=vn")),
                    ),
                    onWebViewCreated: (controller) {
                      debugPrint("Open web success");
                    },
                    onProgressChanged: (controller, progress) {
                      debugPrint("progress: $progress");
                      setState(() {
                        this.progress = progress / 1;
                      });
                    },
                    onLoadStop: (controller, url) async {},
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(colorProject.primaryColor),
            ),
          );
        },
      ),
    );
  }
}
