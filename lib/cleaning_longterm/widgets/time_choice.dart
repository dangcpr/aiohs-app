import 'package:flutter/material.dart';

import '../../utilities/constants/variable.dart';

class TimeChoice extends StatefulWidget {
  const TimeChoice({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<TimeChoice> createState() => _TimeChoiceState();
}

class _TimeChoiceState extends State<TimeChoice> {
  late List<String> days = [
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su',
  ];

  List<bool> isCheck = List.generate(
    7,
    (int index) => false,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          days.length,
          (int index) {
            return InkWell(
              onTap: () {
                setState(
                  () {
                    isCheck[index] = !isCheck[index];
                    switch (index) {
                      case 0:
                        break;

                      case 1:
                        break;

                      case 2:
                        break;
                      case 3:
                        break;
                    }
                  },
                );
              },
              borderRadius: BorderRadius.circular(120),
              splashColor: colorProject.primaryColor,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
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
                    days[index],
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
