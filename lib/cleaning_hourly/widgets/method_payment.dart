import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/utilities/constants/payment_method.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MethodPaymentCleaningHourly extends StatefulWidget {
  const MethodPaymentCleaningHourly({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  State<MethodPaymentCleaningHourly> createState() =>
      _MethodPaymentCleaningHourlyState();
}

class _MethodPaymentCleaningHourlyState
    extends State<MethodPaymentCleaningHourly> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              value = 0;
            });
            context
                .read<SaveInfoCleaningHourlyCubit>()
                .updatePaymentMethod(paymentMethodCode[value]);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: value == 0
                    ? colorProject.primaryColor
                    : const Color.fromARGB(172, 172, 172, 172),
                width: value == 0 ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: value == 0
                      ? colorProject.primaryColor
                      : (widget.isDarkMode ? Colors.white : Colors.black),
                ),
                Flexible(
                  child: Text(
                    "Tiền mặt",
                    style: TextStyle(
                      fontSize: fontSize.mediumLarger,
                      fontFamily: value == 0 ? fontBoldApp : fontApp,
                      color: value == 0
                          ? colorProject.primaryColor
                          : (widget.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                Icon(Icons.navigate_next,
                    color: value == 0
                        ? colorProject.primaryColor
                        : (widget.isDarkMode ? Colors.white : Colors.black)),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            setState(() {
              value = 1;
            });
            context
                .read<SaveInfoCleaningHourlyCubit>()
                .updatePaymentMethod(paymentMethodCode[value]);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: value == 1
                    ? colorProject.primaryColor
                    : const Color.fromARGB(172, 172, 172, 172),
                width: value == 1 ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.payment,
                  color: value == 1
                      ? colorProject.primaryColor
                      : (widget.isDarkMode ? Colors.white : Colors.black),
                ),
                Flexible(
                  child: Text(
                    "Cổng VNPay",
                    style: TextStyle(
                      fontSize: fontSize.mediumLarger,
                      fontFamily: value == 1 ? fontBoldApp : fontApp,
                      color: value == 1
                          ? colorProject.primaryColor
                          : (widget.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                Icon(Icons.navigate_next,
                    color: value == 1
                        ? colorProject.primaryColor
                        : (widget.isDarkMode ? Colors.white : Colors.black)),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        if(zalopay == true) InkWell(
          onTap: () {
            setState(() {
              value = 3;
            });
            context
                .read<SaveInfoCleaningHourlyCubit>()
                .updatePaymentMethod(paymentMethodCode[value]);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: value == 3
                    ? colorProject.primaryColor
                    : const Color.fromARGB(172, 172, 172, 172),
                width: value == 3 ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.payment,
                  color: value == 3
                      ? colorProject.primaryColor
                      : (widget.isDarkMode ? Colors.white : Colors.black),
                ),
                Flexible(
                  child: Text(
                    "Zalopay",
                    style: TextStyle(
                      fontSize: fontSize.mediumLarger,
                      fontFamily: value == 3 ? fontBoldApp : fontApp,
                      color: value == 3
                          ? colorProject.primaryColor
                          : (widget.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                Icon(Icons.navigate_next,
                    color: value == 3
                        ? colorProject.primaryColor
                        : (widget.isDarkMode ? Colors.white : Colors.black)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
