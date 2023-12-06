import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/cleaning_longterm_history.dart';

class HistoryInfoCleaningLongTerm extends StatefulWidget {
  const HistoryInfoCleaningLongTerm(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final CleaningLongTermHistory order;

  @override
  State<HistoryInfoCleaningLongTerm> createState() =>
      _HistoryInfoCleaningLongTermState();
}

class _HistoryInfoCleaningLongTermState
    extends State<HistoryInfoCleaningLongTerm> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime orderDate = new DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(widget.order.orderCleaningLongTerm.workingDate);
    DateTime orderHour = new DateFormat("HH:mm:ss")
        .parse(widget.order.orderCleaningLongTerm.workingHour);

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
                    '${widget.order.detail.orderCleaningSubscription.durationPerDay} ${AppLocalizations.of(context)!.hourLabel}, ${AppLocalizations.of(context)!.fromLabel} ${DateFormat.Hm(locale).format(orderHour)} ${AppLocalizations.of(context)!.toLabel} ${DateFormat.Hm(locale).format(
                      orderHour.add(
                        Duration(
                            hours: widget.order.detail.orderCleaningSubscription
                                .durationPerDay),
                      ),
                    )}, thời gian làm việc ${widget.order.detail.orderCleaningSubscription.numberOfMonth} tháng, '
                    '${widget.order.detail.orderCleaningSubscription.dates.length} ngày/tuần ',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.add_task,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    "${widget.order.detail.orderCleaningSubscription.durationPerDay == 2 ? 55 : (widget.order.detail.orderCleaningSubscription.durationPerDay == 3 ? 85 : 105)} "
                    "m\u00B2 - ${widget.order.detail.orderCleaningSubscription.durationPerDay}"
                    " ${AppLocalizations.of(context)!.roomLabel}",
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
            if (widget.order.detail.orderCleaningSubscription.note.isNotEmpty)
              SizedBox(height: 5),
            if (widget.order.detail.orderCleaningSubscription.note.isNotEmpty)
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
                      widget.order.detail.orderCleaningSubscription.note,
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
