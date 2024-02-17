import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CardReport extends StatefulWidget {
  const CardReport({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.fontSizeTitle = 30,
    this.fontSizeValue = 36,
    this.paddingValue = 20.0,
    this.mainPage = false,
  });

  final String title;
  final double value;
  final IconData icon;
  final double fontSizeTitle;
  final double fontSizeValue;
  final double paddingValue;
  final bool mainPage;

  @override
  State<CardReport> createState() => _CardReportState();
}

class _CardReportState extends State<CardReport> {
  @override
  Widget build(BuildContext context) {
    bool isDarrkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: widget.mainPage == true
          ? MediaQuery.of(context).size.width * 0.4
          : double.infinity,
      padding: EdgeInsets.all(widget.paddingValue),
      decoration: BoxDecoration(
        color: isDarrkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colorProject.primaryColor.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                widget.icon,
                size: widget.fontSizeTitle,
                color: colorProject.primaryColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: widget.mainPage ? BoxFit.fitWidth : BoxFit.none,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: fontSize.mediumLarger,
                      fontFamily: fontBoldApp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            alignment: Alignment.centerLeft,
            fit: widget.mainPage ? BoxFit.fitWidth : BoxFit.none,
            child: Countup(
              begin: 0,
              end: widget.value,
              duration: Duration(seconds: 1),
              separator: '.',
              style: TextStyle(
                fontSize: widget.fontSizeValue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
