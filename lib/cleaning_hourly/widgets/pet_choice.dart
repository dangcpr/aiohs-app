import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetChoice extends StatefulWidget {
  const PetChoice({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<PetChoice> createState() => _PetChoiceState();
}

class _PetChoiceState extends State<PetChoice> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  size: 30,
                  Icons.pets_outlined,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.hasPetLabel,
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.medium,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Switch(
                  value: value,
                  onChanged: (bool newValue) {
                    setState(() {
                      value = newValue;
                    });
                    context.read<SaveInfoCleaningHourlyCubit>().state.hasPet = value;
                    debugPrint(context.read<SaveInfoCleaningHourlyCubit>().state.hasPet.toString());
                  },
                  activeColor: Colors.white,
                  activeTrackColor: colorProject.primaryColor,
                  inactiveThumbColor: widget.isDarkMode ? Colors.white : Colors.black,
                  inactiveTrackColor: Colors.transparent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
