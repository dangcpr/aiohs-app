import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorProject.primaryColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: padding.paddingSmall,
                horizontal: padding.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.event_note, color: colorProject.primaryColor),
                Text(
                  'Quy trình các bước vệ sinh \nmáy lạnh',
                  style: textStyle.headerStyle(fontSize: 14),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        sizedBox.largeHeight(),
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orangeAccent),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: padding.paddingSmall,
                horizontal: padding.paddingSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.safety_check,
                  color: Colors.orangeAccent,
                  size: 40,
                ),
                Text(
                  'Quy trình các bước vệ sinh \nmáy lạnh',
                  style: textStyle.headerStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
