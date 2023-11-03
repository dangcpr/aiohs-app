import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../cleaning_hourly/widgets/text_label.dart';
import '../../cleaning_hourly/widgets/text_sub_label.dart';

class ChooseNumberOfMaid extends StatelessWidget {
  ChooseNumberOfMaid({super.key, required this.numberOfMaid});

  final TextEditingController numberOfMaid;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: "Số lượng nhân viên",
                  isDarkMode: isDarkMode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: TextSubLabel(
                  label: "Nhập số lượng nhân viên cần thuê:",
                  isDarkMode: isDarkMode,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: colorProject.primaryColor.withOpacity(0.07),
                  blurRadius: 30,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: TextField(
              controller: numberOfMaid,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
