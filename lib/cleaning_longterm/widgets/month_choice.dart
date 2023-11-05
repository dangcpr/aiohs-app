import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';

import '../../utilities/constants/variable.dart';

class MonthChoice extends StatefulWidget {
  const MonthChoice({super.key, required this.isDarkMode});
  final bool isDarkMode;
  @override
  State<MonthChoice> createState() => _MonthChoiceState();
}

class _MonthChoiceState extends State<MonthChoice> {
  late List<int> months = [1, 2, 3, 4];

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
                  '${months[index]} tháng',
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
                setState(
                  () {
                    value = selected ? index : 0;
                  },
                );
                context.read<SaveInfoCleaningLongTermCubit>().state.month =
                    months[index];
                debugPrint(context
                    .read<SaveInfoCleaningLongTermCubit>()
                    .state
                    .toJson()
                    .toString());
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
