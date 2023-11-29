import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';

import '../../cleaning_hourly/constants/cleaning_hourly_const.dart';
import '../../utilities/constants/variable.dart';

class WorkInfoCleaningLongTerm extends StatefulWidget {
  const WorkInfoCleaningLongTerm({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<WorkInfoCleaningLongTerm> createState() =>
      _WorkInfoCleaningLongTermState();
}

class _WorkInfoCleaningLongTermState extends State<WorkInfoCleaningLongTerm> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;

    final infoCleaningLongTerm =
        context.read<SaveInfoCleaningLongTermCubit>().state;

    final numberOfDaysOfWeek = infoCleaningLongTerm.days.length;

    final startDay = infoCleaningLongTerm.startDay;
    var daysToWork = infoCleaningLongTerm.month! * 30;
    final endDay = startDay!.add(Duration(days: daysToWork));

    DurationClass duration = listDuration.firstWhere((durationClass) =>
        durationClass.duration == infoCleaningLongTerm.duration);
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
                    "${DateFormat.yMMMMEEEEd(locale).format(infoCleaningLongTerm.startDay!)}, ${DateFormat.Hm(locale).format(infoCleaningLongTerm.time!)}, "
                    "Kết thúc vào ${DateFormat.yMMMMEEEEd(locale).format(endDay)}, ${DateFormat.Hm(locale).format(infoCleaningLongTerm.time!)}",
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
                    '${infoCleaningLongTerm.duration!} ${AppLocalizations.of(context)!.hourLabel}, ${AppLocalizations.of(context)!.fromLabel} ${DateFormat.Hm(locale).format(infoCleaningLongTerm.time!)} ${AppLocalizations.of(context)!.toLabel} ${DateFormat.Hm(locale).format(
                      infoCleaningLongTerm.time!.add(
                        Duration(hours: infoCleaningLongTerm.duration!),
                      ),
                    )}, ${numberOfDaysOfWeek} buổi trong tuần',
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
                    "${duration.area} m\u00B2 - ${duration.numOfRoom} ${AppLocalizations.of(context)!.roomLabel}",
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
            if (context
                .read<SaveInfoCleaningLongTermCubit>()
                .state
                .note!
                .isNotEmpty)
              SizedBox(height: 5),
            if (context
                .read<SaveInfoCleaningLongTermCubit>()
                .state
                .note!
                .isNotEmpty)
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
                      context.read<SaveInfoCleaningLongTermCubit>().state.note!,
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
