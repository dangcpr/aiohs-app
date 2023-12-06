import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/history/models/cooking_history.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/cleaning_longterm_history.dart';

class HistoryInfoCooking extends StatefulWidget {
  const HistoryInfoCooking(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final CookingHistory order;

  @override
  State<HistoryInfoCooking> createState() => _HistoryInfoCookingState();
}

class _HistoryInfoCookingState extends State<HistoryInfoCooking> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime orderDate = new DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(widget.order.orderCooking.workingDate);
    DateTime orderHour =
        new DateFormat("HH:mm:ss").parse(widget.order.orderCooking.workingHour);

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
              AppLocalizations.of(context)!.workingInfoLabel,
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
                  Icons.calendar_month,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '${DateFormat.yMMMMEEEEd(locale).format(orderDate)}, ${DateFormat.Hm(locale).format(orderHour)}',
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.alarm,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '${AppLocalizations.of(context)!.fromLabel} ${DateFormat.Hm(locale).format(orderHour)}',
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.workingInfoDetailLabel,
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontBoldApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Số người ăn'),
                Text('${widget.order.detail.orderHomeCooking.numberOfPeople}'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Danh sách món ăn'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0;
                        i < widget.order.detail.orderHomeCooking.courses.length;
                        i++)
                      Text(widget.order.detail.orderHomeCooking.courses[i])
                  ],
                ),
              ],
            ),
            if (widget.order.detail.orderHomeCooking.note.isNotEmpty)
              SizedBox(height: 5),
            if (widget.order.detail.orderHomeCooking.note.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notes,
                    color: colorProject.primaryColor,
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      widget.order.detail.orderHomeCooking.note,
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
