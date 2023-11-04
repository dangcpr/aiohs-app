import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cleaning_hourly/constants/cleaning_hourly_const.dart';
import '../../cleaning_hourly/cubits/save_info/save_info.dart';
import '../../utilities/constants/variable.dart';

class MonthChoice extends StatefulWidget {
  const MonthChoice({super.key, required this.isDarkMode});
  final bool isDarkMode;
  @override
  State<MonthChoice> createState() => _MonthChoiceState();
}

class _MonthChoiceState extends State<MonthChoice> {
  late List<String> months = [
    '1 Tháng',
    '2 Tháng',
    '3 Tháng',
    '4 Tháng',
  ];

  int value = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 15,
        runSpacing: 10,
        children: List<Widget>.generate(
          months.length,
          (int index) {
            return ChoiceChip(
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  months[index],
                  style: const TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              ),
              selectedColor: colorProject.primaryColor,
              showCheckmark: false,
              selected: index == value,
              labelStyle: TextStyle(
                color: index == value
                    ? Colors.white
                    : (widget.isDarkMode ? Colors.white : Colors.black),
              ),
              onSelected: (bool selected) {
                setState(() {
                  value = selected ? index : 0;
                });
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
