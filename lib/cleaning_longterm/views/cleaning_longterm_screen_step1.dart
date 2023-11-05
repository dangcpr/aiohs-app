import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../cleaning_hourly/views/maps.dart';
import '../../cleaning_hourly/widgets/button_app_bar.dart';
import '../../cleaning_hourly/widgets/text_label.dart';
import '../widgets/button_next_step1.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'Start data: ${context.read<SaveInfoCleaningLongTermCubit>().state.toJson().toString()}');
  }

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
          nameLocation: context.watch<SaveAddressCubit>().state == null ||
                  context.watch<SaveAddressCubit>().state!.shortAddress == ""
              ? "Vui lòng chọn địa điểm"
              : context.watch<SaveAddressCubit>().state!.shortAddress!,
          addressLocation: context.watch<SaveAddressCubit>().state == null ||
                  context.watch<SaveAddressCubit>().state!.address == ""
              ? "Vui lòng chọn địa điểm"
              : context.watch<SaveAddressCubit>().state!.address!,
          isDarkMode: isDarkMode,
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: ChooseLocationScreen(),
                childCurrent: CleaningLongTermStep1(),
              ),
            );
          },
        ),
        leading: InkWell(
          onTap: () {
            context.read<SaveInfoCleaningLongTermCubit>().setInitial();
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: ListView(
          children: [
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
