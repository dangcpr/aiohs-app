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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            clipBehavior: Clip.none,
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
              Positioned(
                right: -25,
                top: -25,
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: MediaQuery.of(context).viewInsets.top + 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                          child: Text(
                            "Hãy lựa chọn tùy chọn này nếu nhà bạn có thú cưng để chúng tôi chọn người giúp việc không bị dị ứng với thú cưng.",
                            style: TextStyle(
                              fontFamily: fontBoldApp,
                              fontSize: fontSize.medium,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon:
                      const Icon(Icons.info, color: colorProject.primaryColor),
                ),
              )
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
                  context.read<SaveInfoCleaningHourlyCubit>().state.hasPet =
                      value;
                  debugPrint(context
                      .read<SaveInfoCleaningHourlyCubit>()
                      .state
                      .hasPet
                      .toString());
                },
                activeColor: Colors.white,
                activeTrackColor: colorProject.primaryColor,
                inactiveThumbColor:
                    widget.isDarkMode ? Colors.white : Colors.black,
                inactiveTrackColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
