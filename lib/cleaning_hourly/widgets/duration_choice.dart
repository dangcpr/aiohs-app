import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/constants/cleaning_hourly_const.dart';
import 'package:rmservice/cleaning_hourly/cubits/price_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/models/cleaning_hourly_price.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DurationChoice extends StatefulWidget {
  const DurationChoice({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<DurationChoice> createState() => _DurationChoiceState();
}

class _DurationChoiceState extends State<DurationChoice> {
  DurationClass durationChoice = DurationClass();

  @override
  Widget build(BuildContext context) {
    int _value = BlocProvider.of<SaveInfoCleaningHourlyCubit>(context, listen: true).state.duration! - 2;
    CleaningHourlyPrice cleaningHourlyPrice = context.read<PriceCleaningHourlyCubit>().state;

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 2,
        runSpacing: 7,
        children: List<Widget>.generate(
          listDuration.length,
          (int index) {
            return ChoiceChip(
              label: Column(
                children: [
                  Text(
                    "${listDuration[index].duration} ${AppLocalizations.of(context)!.hourLabel}",
                    style: const TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.mediumLarger,
                    ),
                  ),

                  Text(
                    '${listDuration[index].area} m\u00B2',
                    style: const TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  ),

                  Text(
                    '${listDuration[index].numOfRoom} ${AppLocalizations.of(context)!.roomLabel}',
                    style: const TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                ],
              ),
              selectedColor: colorProject.primaryColor,
              showCheckmark: false,
              selected: index == _value,
              labelStyle: TextStyle(
                color: index == _value
                    ? Colors.white
                    : (widget.isDarkMode ? Colors.white : Colors.black),
              ),
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : 0;
                });
                context.read<SaveInfoCleaningHourlyCubit>().updateDuration(listDuration[_value].duration!);
                context.read<SaveInfoCleaningHourlyCubit>().updatePrice(cleaningHourlyPrice);
                
                debugPrint(jsonEncode(context.read<SaveInfoCleaningHourlyCubit>().state));
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
