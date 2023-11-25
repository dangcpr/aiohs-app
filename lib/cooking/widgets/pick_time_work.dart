import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PickTimeWork extends StatefulWidget {
  const PickTimeWork({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<PickTimeWork> createState() => _PickTimeWorkState();
}

class _PickTimeWorkState extends State<PickTimeWork> {
  @override
  Widget build(BuildContext context) {
    TimeOfDay? time = TimeOfDay.fromDateTime(
        context.read<SaveInfoCookingCubit>().state.time!);

    DateTime timeChoose = DateTime(1969, 1, 1, time.hour, time.minute);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            AppLocalizations.of(context)!.timeSub,
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white : Colors.black,
              fontFamily: fontApp,
              fontSize: fontSize.medium,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            TimeOfDay? newTime = await showTimePicker(
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: colorProject.primaryColor,
                    colorScheme: widget.isDarkMode
                        ? ColorScheme.dark(
                            primary: colorProject.primaryColor,
                          )
                        : ColorScheme.light(
                            primary: colorProject.primaryColor,
                          ),
                    buttonTheme: ButtonThemeData(),
                  ),
                  child: child!,
                );
              },
              context: context,
              initialTime: time!,
            );
            if (newTime != null) {
              setState(() {
                time = newTime;
                timeChoose = DateTime(1969, 1, 1, time!.hour, time!.minute);
              });
              context.read<SaveInfoCookingCubit>().state.time = timeChoose;
              debugPrint(context
                  .read<SaveInfoCookingCubit>()
                  .state
                  .toJson()
                  .toString());
            }
          },
          child: Ink(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.isDarkMode ? Colors.white : Colors.black,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
            ),
            child: Center(
              child: Text(
                DateFormat('Hm').format(timeChoose),
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: fontBoldApp,
                  fontSize: fontSize.large,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
