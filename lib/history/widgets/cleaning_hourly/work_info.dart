import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryInfoCleaningHourly extends StatefulWidget {
  const HistoryInfoCleaningHourly(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final CleaningHourlyHistory order;

  @override
  State<HistoryInfoCleaningHourly> createState() => _HistoryInfoCleaningHourlyState();
}

class _HistoryInfoCleaningHourlyState extends State<HistoryInfoCleaningHourly> {
  @override
  Widget build(BuildContext context) {
    String addService =
        (widget.order.with_home_cooking
                ? "${AppLocalizations.of(context)!.cookingLabel}, "
                : "") +
            (widget.order.with_laundry
                ? "${AppLocalizations.of(context)!.ironLabel}, "
                : ""); 
            //     +
            // (widget.order.with_bring_tools
            //     ? "${AppLocalizations.of(context)!.bringToolLabel}, "
            //     : "") +
            // (context.read<SaveInfoCleaningHourlyCubit>().state.bringVaccum!
            //     ? "${AppLocalizations.of(context)!.bringVaccumLabel}, "
            //     : "");
    addService = addService.isNotEmpty ? addService.substring(0, addService.length - 2) : addService;

    String locale = Localizations.localeOf(context).languageCode;
    DateTime orderDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.order.working_date);
    DateTime orderHour =
        new DateFormat("HH:mm:ss").parse(widget.order.working_hour);

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
                    '${widget.order.duration} ${AppLocalizations.of(context)!.hourLabel}, ${AppLocalizations.of(context)!.fromLabel} ${DateFormat.Hm(locale).format(orderHour)} ${AppLocalizations.of(context)!.toLabel} ${DateFormat.Hm(locale).format(orderHour.add(Duration(hours: widget.order.duration)))}',
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
                    "${widget.order.duration == 2 ? 55 : (widget.order.duration == 3 ? 85 : 105)} m\u00B2 - ${widget.order.duration} ${AppLocalizations.of(context)!.roomLabel}",
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            if (addService.isNotEmpty) SizedBox(height: 5),
            if (addService.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.library_add,
                    color: colorProject.primaryColor,
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      addService,
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
                  Icons.pets,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.order.house_with_pet == true
                        ? AppLocalizations.of(context)!.yesPetLabel
                        : AppLocalizations.of(context)!.noPetLabel,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontBoldApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            if (widget.order.note.isNotEmpty) SizedBox(height: 5),
            if (widget.order.note.isNotEmpty)
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
                      widget.order.note,
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
