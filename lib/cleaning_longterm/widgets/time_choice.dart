import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';

import '../../utilities/constants/variable.dart';

class TimeChoice extends StatefulWidget {
  const TimeChoice({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<TimeChoice> createState() => _TimeChoiceState();
}

class _TimeChoiceState extends State<TimeChoice> {
  final items = List<DateTime>.generate(
      7, (i) => DateTime.now().add(Duration(days: i + 1)));
  int value = 0;

  List<bool> isCheck = List.generate(
    7,
    (int index) => false,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String locale = Localizations.localeOf(context).languageCode;
    List<DateTime> days =
        context.read<SaveInfoCleaningLongTermCubit>().state.days;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          items.length,
          (int index) {
            return InkWell(
              onTap: () {
                setState(
                  () {
                    isCheck[index] = !isCheck[index];
                    int indexOfDay = context
                        .read<SaveInfoCleaningLongTermCubit>()
                        .checkDay(items[index], days);
                    if (indexOfDay != -1) {
                      context
                          .read<SaveInfoCleaningLongTermCubit>()
                          .remove(indexOfDay);
                      print('Deleted at $indexOfDay');
                    } else {
                      context
                          .read<SaveInfoCleaningLongTermCubit>()
                          .addDay(items[index]);
                      print('Added');
                    }
                    context.read<SaveInfoCleaningLongTermCubit>().checkStartDay(
                        context
                            .read<SaveInfoCleaningLongTermCubit>()
                            .state
                            .days);
                    debugPrint(context
                        .read<SaveInfoCleaningLongTermCubit>()
                        .state
                        .days
                        .toString());
                  },
                );
              },
              borderRadius: BorderRadius.circular(120),
              splashColor: colorProject.primaryColor,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                margin: EdgeInsets.all(size.width / 120),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    width: 0.5,
                  ),
                  color: isCheck[index]
                      ? colorProject.primaryColor
                      : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(padding.paddingSmall),
                  child: Text(
                    DateFormat.E(locale).format(items[index]).toString(),
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
