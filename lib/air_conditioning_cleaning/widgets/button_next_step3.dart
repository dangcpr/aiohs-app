import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/views/air_conditioning_cleaning_screen_step3.dart';
import 'package:rmservice/air_conditioning_cleaning/views/complete_screen.dart';

import '../../utilities/components/button_green.dart';

class ButtonNextStep3 extends StatelessWidget {
  const ButtonNextStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonGreenApp(
            label: "Tiếp theo",
            onPressed: () async {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: CompleteScreen(),
                  childCurrent: AirConditioningCleaningScreenStep3(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
