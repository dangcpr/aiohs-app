import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/models/air_conditioning_history.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryInfoCleaningAirCond extends StatefulWidget {
  const HistoryInfoCleaningAirCond(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final CleaningAirCondHistory order;

  @override
  State<HistoryInfoCleaningAirCond> createState() =>
      _HistoryInfoCleaningAirCondState();
}

class _HistoryInfoCleaningAirCondState
    extends State<HistoryInfoCleaningAirCond> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime orderDate = new DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(widget.order.orderAirCondHistory.workingDate);
    DateTime orderHour = new DateFormat("HH:mm:ss")
        .parse(widget.order.orderAirCondHistory.workingHour);
    var detail = widget.order.detail.orderAirConditioningClean;

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
            workInfoContainer(
              'Wall - Below 2HP',
              detail.wall.numberBellow_2hp,
              detail.wall.gasRefillBellow_2hp,
            ),
            workInfoContainer(
              'Wall - Above 2HP',
              detail.wall.numberAbove_2hp,
              detail.wall.gasRefillAbove_2hp,
            ),
            workInfoContainer(
              'Portable',
              detail.portable.numberAc,
              detail.portable.gasRefill,
            ),
            workInfoContainer(
              'Cassette - Below 3HP',
              detail.cassette.numberBellow_3hp,
              detail.cassette.gasRefillBellow_3hp,
            ),
            workInfoContainer(
              'Cassette - Above 3HP',
              detail.cassette.numberAbove_3hp,
              detail.cassette.gasRefillAbove_3hp,
            ),
            workInfoContainer(
              'Floor - Below 5HP',
              detail.floor.numberBellow_5hp,
              detail.floor.gasRefillBellow_5hp,
            ),
            workInfoContainer(
              'Floor - Above 5HP',
              detail.floor.numberAbove_5hp,
              detail.floor.gasRefillAbove_5hp,
            ),
            workInfoContainer(
              'Build_in',
              detail.builtIn.numberAc,
              detail.builtIn.gasRefill,
            ),
            SizedBox(height: 5),
            if (widget.order.detail.orderAirConditioningClean.note.isNotEmpty)
              SizedBox(height: 5),
            if (widget.order.detail.orderAirConditioningClean.note.isNotEmpty)
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
                      widget.order.detail.orderAirConditioningClean.note,
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

  Widget workInfoContainer(String text, int amount, int amountHasGas) {
    return amount != 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Công việc:'),
                  amountHasGas != 0
                      ? Text('Vệ sinh: x${amount}, Bơm gas: x${amountHasGas}')
                      : Text('Vệ sinh: x${amount}'),
                ],
              )
            ],
          )
        : SizedBox();
  }
}
