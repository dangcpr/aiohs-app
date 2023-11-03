import 'package:flutter/material.dart';

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

  List<bool> isCheck = List.generate(
    4,
    (int index) => false,
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: List<Widget>.generate(
        months.length,
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
            splashColor: colorProject.primaryColor,
            child: Container(
              alignment: Alignment.center,
              width: size.width / 2.5,
              margin: EdgeInsets.all(size.width / 120),
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
              child: Padding(
                padding: const EdgeInsets.all(padding.paddingMedium),
                child: Text(
                  months[index],
                  style: textStyle.normalStyle(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
