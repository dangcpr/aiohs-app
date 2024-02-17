import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class InfoLine extends StatefulWidget {
  const InfoLine(
      {super.key, required this.title, this.content, required this.icon});

  final String title;
  final String? content;
  final IconData icon;

  @override
  State<InfoLine> createState() => _InfoLineState();
}

class _InfoLineState extends State<InfoLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.icon,
          color: colorProject.primaryColor,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontFamily: fontBoldApp, fontSize: fontSize.medium),
              ),
              if (widget.content != null)
                Text(
                  widget.content!,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.medium,
                    // color: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
