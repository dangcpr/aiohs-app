import 'package:flutter/material.dart';
import 'package:rmservice/history/models/cooking_history.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryLocationInfoCooking extends StatefulWidget {
  const HistoryLocationInfoCooking(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final CookingHistory order;

  @override
  State<HistoryLocationInfoCooking> createState() =>
      _HistoryLocationInfoCookingState();
}

class _HistoryLocationInfoCookingState
    extends State<HistoryLocationInfoCooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(172, 172, 172, 172), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin người thuê",
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontBoldApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.order.orderCooking.agentName,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.code,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.order.orderCooking.agentPhone,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.order.orderCooking.workingAddress,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
