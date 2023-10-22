import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/constants/cleaning_hourly_const.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class AddServiceChoice extends StatefulWidget {
  const AddServiceChoice({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<AddServiceChoice> createState() => _AddServiceChoiceState();
}

class _AddServiceChoiceState extends State<AddServiceChoice> {
  List<bool> isCheck = List.generate(
    listAddService.length,
    (int index) => false,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 14,
      children: List<Widget>.generate(
        listAddService.length,
        (int index) {
          return InkWell(
            onTap: () {
              setState(() {
                isCheck[index] = !isCheck[index];
              });
              debugPrint("Selected ${index}: ${isCheck[index]}");
            },
            child: Ink(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                  width: 0.5,
                ),
                color: isCheck[index]
                    ? colorProject.primaryColor
                    : Colors.transparent,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 13),
                        Icon(
                          size: 30,
                          listAddService[index].icon,
                          color: isCheck[index]
                              ? Colors.white
                              : (widget.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        SizedBox(width: 10),
                        Text(
                          listAddService[index].name!,
                          style: TextStyle(
                            fontFamily: fontApp,
                            fontSize: fontSize.medium,
                            color: isCheck[index]
                                ? Colors.white
                                : (widget.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          listAddService[index].action!,
                          style: TextStyle(
                            fontFamily: fontApp,
                            fontSize: fontSize.medium,
                            color: isCheck[index]
                                ? Colors.white
                                : (widget.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),

                        SizedBox(width: 13)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
