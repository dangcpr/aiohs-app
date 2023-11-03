import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoticeStep1 extends StatefulWidget {
  const NoticeStep1({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<NoticeStep1> createState() => _NoticeStep1State();
}

class _NoticeStep1State extends State<NoticeStep1> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: TextStyle(fontSize: fontSize.medium),
        ),
        SizedBox(width: 8),
        Flexible(
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '${AppLocalizations.of(context)!.noticeLabel}: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: fontBoldApp,
                  ),
                ),
                TextSpan(
                  text:
                      AppLocalizations.of(context)!.fourHourNotice,
                  style: TextStyle(
                    fontFamily: fontApp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
