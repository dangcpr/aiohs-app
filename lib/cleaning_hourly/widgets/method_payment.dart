import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Xác nhận');
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(172, 172, 172, 172),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: colorProject.primaryColor,
            ),
            Flexible(
              child: Text(
                "Tiền mặt",
                style: TextStyle(
                  fontSize: fontSize.mediumLarger,
                  fontFamily: fontBoldApp,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
