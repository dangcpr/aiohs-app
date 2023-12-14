import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/post_job/views/post_job_screen.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ButtonPostJob extends StatefulWidget {
  const ButtonPostJob({super.key});

  @override
  State<ButtonPostJob> createState() => _ButtonPostJobState();
}

class _ButtonPostJobState extends State<ButtonPostJob> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        //color: colorProject.primaryColor.withOpacity(0.4),
        color: const Color.fromARGB(255, 0, 239, 167).withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            'Bạn muốn tìm giúp việc/tìm việc linh hoạt hơn?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize.mediumLarger + 1,
              fontFamily: fontBoldApp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: PostJobScreen(),
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Tin tìm giúp việc",
                style: TextStyle(
                  fontSize: fontSize.mediumLarger + 1,
                  fontFamily: fontBoldApp,
                  color: Colors.black54,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
