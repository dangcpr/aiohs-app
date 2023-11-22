import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/cleaning_hourly/constants/cleaning_hourly_const.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkInfoCleaningAirConditioning extends StatefulWidget {
  const WorkInfoCleaningAirConditioning({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<WorkInfoCleaningAirConditioning> createState() =>
      _WorkInfoCleaningAirConditioningState();
}

class _WorkInfoCleaningAirConditioningState
    extends State<WorkInfoCleaningAirConditioning> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(context.read<SaveInfoAirConditioningCleaningCubit>().state.toJson());
  }

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    final infoCleaningHourly =
        context.read<SaveInfoAirConditioningCleaningCubit>().state;

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
            ListView.builder(
              itemCount: infoCleaningHourly.details.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Details detail = infoCleaningHourly.details[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding.paddingSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${detail.type} - ${detail.detail}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Công việc:'),
                          detail.hasGas
                              ? Text('Vệ sinh, Bơm gas: x${detail.amount}')
                              : Text('Vệ sinh: x${detail.amount}'),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
