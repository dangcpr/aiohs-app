import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_next_step2.dart';
import 'package:rmservice/cleaning_hourly/widgets/note_for_maid.dart';
import 'package:rmservice/cleaning_hourly/widgets/notice_step2.dart';
import 'package:rmservice/cleaning_hourly/widgets/pick_date_work.dart';
import 'package:rmservice/cleaning_hourly/widgets/pick_time_work.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_label.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_sub_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CleaningHourlyStep2Screen extends StatefulWidget {
  const CleaningHourlyStep2Screen({super.key});

  @override
  State<CleaningHourlyStep2Screen> createState() =>
      _CleaningHourlyStep2ScreenState();
}

class _CleaningHourlyStep2ScreenState extends State<CleaningHourlyStep2Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          AppLocalizations.of(context)!.confirmCleaningHourly,
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.dateLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label: AppLocalizations.of(context)!.dateSub,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: PickDateWork(
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PickTimeWork(
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: NoticeStep2(
                  isDarkMode: isDarkMode,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.noticeForMaidLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label: AppLocalizations.of(context)!.noticeForMaidSub,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: NoteForMaid(
                isDarkMode: isDarkMode,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ButtonNextStep2(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
