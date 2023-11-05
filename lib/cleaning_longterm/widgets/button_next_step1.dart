import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_longterm/cleaning_longterm.dart';
import 'package:rmservice/utilities/components/button_green.dart';

import '../views/cleaning_longterm_screen_step2.dart';

class ButtonNextStep1 extends StatefulWidget {
  const ButtonNextStep1({super.key});

  @override
  State<ButtonNextStep1> createState() => _ButtonNextStep1State();
}

class _ButtonNextStep1State extends State<ButtonNextStep1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: ButtonGreenApp(
        label: "Tiếp theo",
        onPressed: () {
          /*
          if (context.read<SaveInfoCleaningHourlyCubit>().state.location ==
              null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 50,
                  ),
                  content: Text(
                    textAlign: TextAlign.center,
                    "Bạn chưa chọn địa điểm",
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.mediumLarger,
                    )
                  ),
                );
              },
            );
            return;
          }
          */
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: CleaningLongTermStep2(),
              childCurrent: CleaningLongTermStep1(),
            ),
          );
        },
      ),
    );
  }
}
