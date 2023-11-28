import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
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
    final infoAirCleaning =
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
                    '${DateFormat.yMMMMEEEEd(locale).format(infoAirCleaning.date!)}, ${DateFormat.Hm(locale).format(infoAirCleaning.time!)}',
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
                    '${infoAirCleaning.realDuration} ${AppLocalizations.of(context)!.hourLabel}, ${AppLocalizations.of(context)!.fromLabel} ${DateFormat.Hm(locale).format(infoAirCleaning.time!)} ${AppLocalizations.of(context)!.toLabel} ${DateFormat.Hm(locale).format(infoAirCleaning.time!.add(Duration(hours: infoAirCleaning.realDuration!)))}',
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
              itemCount: infoAirCleaning.details.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Details detail = infoAirCleaning.details[index];
                return detail.amount != 0
                    ? Padding(
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
                                    ? Text(
                                        'Vệ sinh, Bơm gas: x${detail.amount}')
                                    : Text('Vệ sinh: x${detail.amount}'),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      )
                    : SizedBox();
              },
            ),
            if (context
                .read<SaveInfoAirConditioningCleaningCubit>()
                .state
                .note!
                .isNotEmpty)
              Text(
                AppLocalizations.of(context)!.noticeForMaidLabel,
                style: TextStyle(
                  fontSize: fontSize.medium,
                  fontFamily: fontBoldApp,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            if (context
                .read<SaveInfoAirConditioningCleaningCubit>()
                .state
                .note!
                .isNotEmpty)
              SizedBox(height: 5),
            if (context
                .read<SaveInfoAirConditioningCleaningCubit>()
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
                      context
                          .read<SaveInfoAirConditioningCleaningCubit>()
                          .state
                          .note!,
                      style: TextStyle(
                        fontSize: fontSize.medium,
                        fontFamily: fontApp,
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
