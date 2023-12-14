import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/maid_near/models/maid_res.dart';
import 'package:rmservice/utilities/widget/see_maps.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MaidContactTab extends StatefulWidget {
  const MaidContactTab({super.key, required this.maidNear});

  final MaidRes maidNear;

  @override
  State<MaidContactTab> createState() => _MaidContactTabState();
}

class _MaidContactTabState extends State<MaidContactTab> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.phone,
                color: colorProject.primaryColor,
              ),
              SizedBox(width: 5),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Số điện thoại: ',
                        style: TextStyle(
                          fontFamily: fontBoldApp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: widget.maidNear.phone_number,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: colorProject.primaryColor,
              ),
              SizedBox(width: 5),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Địa chỉ liên lạc: ',
                        style: TextStyle(
                          fontFamily: fontBoldApp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: widget.maidNear.address,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ButtonGreenApp(
            label: "Địa chỉ trên Google Maps",
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: SeeMapPlace(
                    title: widget.maidNear.name,
                    appBarTitle: "Địa chỉ của ${widget.maidNear.name}",
                    address: widget.maidNear.address,
                    latitude: widget.maidNear.latitude,
                    longtitude: widget.maidNear.longitude,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          ButtonGreenApp(
            label: "Chat với người giúp việc",
            onPressed: () {
              null;
            },
          )
        ],
      ),
    );
  }
}
