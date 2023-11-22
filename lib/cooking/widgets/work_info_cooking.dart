import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkInfoCooking extends StatefulWidget {
  const WorkInfoCooking({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<WorkInfoCooking> createState() => _WorkInfoCookingState();
}

class _WorkInfoCookingState extends State<WorkInfoCooking> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    final infoCooking = context.read<SaveInfoCookingCubit>().state;
    late int temp = 0;

    if (infoCooking.realDuration > 2) {
      temp = 30;
    }

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
                    '${DateFormat.yMMMMEEEEd(locale).format(infoCooking.date!)}, ${DateFormat.Hm(locale).format(infoCooking.time!)}',
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
                    '${infoCooking.realDuration!} ${AppLocalizations.of(context)!.hourLabel},'
                    ' ${AppLocalizations.of(context)!.fromLabel} '
                    '${DateFormat.Hm(locale).format(infoCooking.time!)}'
                    ' ${AppLocalizations.of(context)!.toLabel} ${DateFormat.Hm(locale).format(
                      infoCooking.time!.add(
                        Duration(hours: infoCooking.duration, minutes: temp),
                      ),
                    )}',
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
                Text('${infoCooking.numberOfPeople}')
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Danh sách\nmón ăn'),
                Column(
                  children: [
                    infoCooking.food1 != ""
                        ? Text('${infoCooking.food1}')
                        : SizedBox(),
                    infoCooking.food2 != ""
                        ? Text('${infoCooking.food2}')
                        : SizedBox(),
                    infoCooking.food3 != ""
                        ? Text('${infoCooking.food3}')
                        : SizedBox(),
                    infoCooking.food4 != ""
                        ? Text('${infoCooking.food4}')
                        : SizedBox(),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            infoCooking.fruit
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trái cây'),
                      Text('Có'),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Khẩu vị'),
                Text('${infoCooking.taste}'),
              ],
            ),
            SizedBox(height: 5),
            infoCooking.bonusService != 0
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Người làm đi chợ'),
                          Text('Có'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Chi phí đi chợ'),
                          Text(
                              '${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(infoCooking.bonusService)}'),
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(height: 5),
            infoCooking.hasPet
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nhà có thú cưng'),
                      Text('Có'),
                    ],
                  )
                : SizedBox(),
            if (context.read<SaveInfoCookingCubit>().state.note!.isNotEmpty)
              SizedBox(height: 5),
            if (context.read<SaveInfoCookingCubit>().state.note!.isNotEmpty)
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
                      context.read<SaveInfoCookingCubit>().state.note!,
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
