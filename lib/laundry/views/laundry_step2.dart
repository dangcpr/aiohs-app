import 'package:flutter/material.dart';
import 'package:rmservice/laundry/widgets/button/button_next_step2.dart';
import 'package:rmservice/laundry/widgets/note_for_maid.dart';
import 'package:rmservice/laundry/widgets/notice_step2.dart';
import 'package:rmservice/laundry/widgets/pick_receive_date.dart';
//import 'package:rmservice/laundry/widgets/pick_receive_time.dart';
import 'package:rmservice/laundry/widgets/pick_send_date.dart';
import 'package:rmservice/laundry/widgets/pick_send_time.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LaundryStep2Screen extends StatefulWidget {
  const LaundryStep2Screen({super.key});

  @override
  State<LaundryStep2Screen> createState() => _LaundryStep2ScreenState();
}

class _LaundryStep2ScreenState extends State<LaundryStep2Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Chọn thời gian nhận và trả đồ",
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
                label: "Thời gian nhận đồ",
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label:
                    "Vui lòng chọn ngày cộng tác viên nhận đồ (trong vòng 7 ngày)",
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: PickSendDate(
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PickSendTime(
                isDarkMode: isDarkMode,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: "Thời gian trả đồ",
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label:
                    "Vui lòng chọn ngày cộng tác viên trả đồ (trong vòng 7 ngày)",
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: PickReceiveDate(
                isDarkMode: isDarkMode,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: PickReceiveTime(
            //     isDarkMode: isDarkMode,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: NoticeStep2(
                isDarkMode: isDarkMode,
              ),
            ),
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
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonNextStep2Laundry(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
