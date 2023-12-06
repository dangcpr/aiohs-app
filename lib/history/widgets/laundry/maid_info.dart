import 'package:flutter/material.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class HistoryMaidInfoLaundry extends StatefulWidget {
  const HistoryMaidInfoLaundry(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final LaundryHistory order;

  @override
  State<HistoryMaidInfoLaundry> createState() =>
      _HistoHistoryMaidInfoLaundryState();
}

class _HistoHistoryMaidInfoLaundryState
    extends State<HistoryMaidInfoLaundry> {
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
              "Thông tin người giúp việc",
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
                    widget.order.maid_name,
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
                    widget.order.maid_code,
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
          ],
        ),
      ),
    );
  }
}
