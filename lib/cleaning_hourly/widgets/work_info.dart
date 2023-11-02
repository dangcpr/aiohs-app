import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cleaning_hourly/constants/cleaning_hourly_const.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkInfoCleaningHourly extends StatefulWidget {
  const WorkInfoCleaningHourly({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<WorkInfoCleaningHourly> createState() => _WorkInfoCleaningHourlyState();
}

class _WorkInfoCleaningHourlyState extends State<WorkInfoCleaningHourly> {
  @override
  Widget build(BuildContext context) {
    String addService =
        (context.read<SaveInfoCleaningHourlyCubit>().state.cooking!
                ? "${AppLocalizations.of(context)!.cookingLabel}, "
                : "") +
            (context.read<SaveInfoCleaningHourlyCubit>().state.iron!
                ? "${AppLocalizations.of(context)!.ironLabel}, "
                : "") +
            (context.read<SaveInfoCleaningHourlyCubit>().state.bringTool!
                ? "${AppLocalizations.of(context)!.bringToolLabel}, "
                : "") +
            (context.read<SaveInfoCleaningHourlyCubit>().state.bringVaccum!
                ? "${AppLocalizations.of(context)!.bringVaccumLabel}, "
                : "");

    addService = addService.isNotEmpty
        ? addService = addService.substring(0, addService.length - 2)
        : addService = addService;

    DurationClass duration = listDuration.firstWhere((durationClass) =>
        durationClass.duration ==
        context.read<SaveInfoCleaningHourlyCubit>().state.realDuration!);

    String locale = Localizations.localeOf(context).languageCode;
    final infoCleaningHourly =
        context.read<SaveInfoCleaningHourlyCubit>().state;

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
                    '${DateFormat.yMMMMEEEEd(locale).format(infoCleaningHourly.date!)}, ${DateFormat.Hm(locale).format(infoCleaningHourly.time!)}',
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
                    '${infoCleaningHourly.realDuration!} ${AppLocalizations.of(context)!.hourLabel}, ${AppLocalizations.of(context)!.fromLabel} ${DateFormat.Hm(locale).format(infoCleaningHourly.time!)} ${AppLocalizations.of(context)!.toLabel} ${DateFormat.Hm(locale).format(infoCleaningHourly.time!.add(Duration(hours: infoCleaningHourly.realDuration!)))}',
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
                    context.read<SaveInfoCleaningHourlyCubit>().state.hasPet ==
                            true
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
            if(context.read<SaveInfoCleaningHourlyCubit>().state.note!.isNotEmpty) SizedBox(height: 5),
            if(context.read<SaveInfoCleaningHourlyCubit>().state.note!.isNotEmpty) Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notes,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    context.read<SaveInfoCleaningHourlyCubit>().state.note!,
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
