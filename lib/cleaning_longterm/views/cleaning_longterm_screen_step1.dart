import 'package:flutter/material.dart';
import '../../cleaning_hourly/widgets/button_app_bar.dart';
import '../../cleaning_hourly/widgets/text_label.dart';
import '../../cleaning_hourly/widgets/text_sub_label.dart';
import '../widgets/button_next_step1.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../widgets/choose_number_of_maid.dart';
import '../widgets/duration_choices.dart';
import '../widgets/month_choice.dart';
import '../widgets/note_for_maid.dart';
import '../widgets/pick_time_work.dart';
import '../widgets/time_choice.dart';

class CleaningLongTermStep1 extends StatefulWidget {
  const CleaningLongTermStep1({super.key});

  @override
  State<CleaningLongTermStep1> createState() => _CleaningLongTermStep1State();
}

class _CleaningLongTermStep1State extends State<CleaningLongTermStep1> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final TextEditingController numberOfMaid = TextEditingController();
    List<bool> values = List.filled(7, false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ButtonChooseLocation(
          nameLocation: 'Vui lòng chọn địa điểm',
          addressLocation: 'Vui lòng chọn địa điểm',
          isDarkMode: isDarkMode,
          onPressed: () {
            debugPrint('Vui lòng chọn địa điểm');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: ListView(
          children: [
            ChooseNumberOfMaid(numberOfMaid: numberOfMaid),
            Padding(
              padding: const EdgeInsets.only(top: padding.paddingMedium),
              child: TextLabel(
                label: "Ngày",
                isDarkMode: isDarkMode,
              ),
            ),
            sizedBox.smallHeight(),
            TimeChoice(isDarkMode: isDarkMode),
            sizedBox.mediumHeight(),
            TextLabel(
              label: "Giờ bắt đầu",
              isDarkMode: isDarkMode,
            ),
            PickTimeWork(
              isDarkMode: isDarkMode,
            ),
            sizedBox.mediumHeight(),
            TextLabel(
              label: "Thời lượng công việc",
              isDarkMode: isDarkMode,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DurationChoice(
                isDarkMode: isDarkMode,
              ),
            ),
            sizedBox.mediumHeight(),
            TextLabel(
              label: "Số tháng cần thuê",
              isDarkMode: isDarkMode,
            ),
            MonthChoice(isDarkMode: isDarkMode),
            sizedBox.mediumHeight(),
            TextLabel(
              label: "Ghi chú cho người làm để người làm dọn dẹp tốt hơn.",
              isDarkMode: isDarkMode,
            ),
            NoteForMaid(
              isDarkMode: isDarkMode,
            )
          ],
        ),
      ),
      floatingActionButton: const ButtonNextStep1(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
