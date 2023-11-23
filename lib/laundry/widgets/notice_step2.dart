import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoticeStep2 extends StatefulWidget {
  const NoticeStep2({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<NoticeStep2> createState() => _NoticeStep2State();
}

class _NoticeStep2State extends State<NoticeStep2> {
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
                  text: AppLocalizations.of(context)!.timeNotice,
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
