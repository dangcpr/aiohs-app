import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/maid_near/models/maid_res.dart';
import 'package:rmservice/maid_near/views/maid_view.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MaidNearCard extends StatefulWidget {
  const MaidNearCard({super.key, required this.maidNear});
  final MaidRes maidNear;

  @override
  State<MaidNearCard> createState() => _MaidNearCardState();
}

class _MaidNearCardState extends State<MaidNearCard> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(milliseconds: 400),
            type: PageTransitionType.rightToLeftWithFade,
            child: MaidView(maidNear: widget.maidNear),
          )
        );
      },
      child: Container(
        width: size / 3.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.maidNear.avatar_url == ''
                ? CircleAvatar(child: Image.asset('assets/images/avatar.png'))
                : CircleAvatar(
                    backgroundImage: NetworkImage(widget.maidNear.avatar_url),
                    radius: 40,
                  ),
            Text(
              textAlign: TextAlign.center,
              widget.maidNear.name,
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
                color: colorProject.primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Color.fromARGB(255, 255, 235, 59)),
                Text(
                  widget.maidNear.avg_star.toStringAsFixed(1),
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
