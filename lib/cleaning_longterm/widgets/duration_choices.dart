import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/constants/cleaning_hourly_const.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

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
    int _value =
        BlocProvider.of<SaveInfoCleaningLongTermCubit>(context, listen: true)
                .state
                .duration -
            2;
    late List<int> values = [1, 2, 3];
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
                    listDuration[index].duration.toString() + ' giờ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.mediumLarger,
                    ),
                  ),
                  Text(
                    listDuration[index].area.toString() + ' m' + '\u00B2',
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Text(
                    listDuration[index].numOfRoom.toString() + ' phòng',
                    style: TextStyle(
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
                context.read<SaveInfoCleaningLongTermCubit>().state.duration =
                    listDuration[_value].duration!;
                print(context
                    .read<SaveInfoCleaningLongTermCubit>()
                    .state
                    .duration
                    .toString());
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
