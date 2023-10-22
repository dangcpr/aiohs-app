import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PickTimeWork extends StatefulWidget {
  const PickTimeWork({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<PickTimeWork> createState() => _PickTimeWorkState();
}

class _PickTimeWorkState extends State<PickTimeWork> {
  TimeOfDay? time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    DateTime timeChoose = DateTime(1969, 1, 1, time!.hour, time!.minute);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "Vui lòng chọn giờ bắt đầu làm việc",
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
              
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (newTime != null) {
              setState(() {
                time = newTime;
              });
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
