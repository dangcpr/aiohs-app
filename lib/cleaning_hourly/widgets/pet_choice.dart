import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

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
                  "Nhà có thú cưng",
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
                    debugPrint(value.toString());
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
