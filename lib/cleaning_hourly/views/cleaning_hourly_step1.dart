import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';
import 'package:rmservice/cleaning_hourly/widgets/add_service_choice.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_app_bar.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_next_step1.dart';
import 'package:rmservice/cleaning_hourly/widgets/duration_choice.dart';
import 'package:rmservice/cleaning_hourly/widgets/notice_step1.dart';
import 'package:rmservice/cleaning_hourly/widgets/pet_choice.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_label.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_sub_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CleaningHourlyStep1Screen extends StatefulWidget {
  const CleaningHourlyStep1Screen({super.key});

  @override
  State<CleaningHourlyStep1Screen> createState() =>
      _CleaningHourlyStep1ScreenState();
}

class _CleaningHourlyStep1ScreenState extends State<CleaningHourlyStep1Screen> {
  //
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    InfoCleaningHourly infoCleaningHourly = InfoCleaningHourly();

    @override
    void initState() {
      super.initState();
      infoCleaningHourly = context.read<SaveInfoCleaningHourlyCubit>().state;
    }

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
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.durationLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label: AppLocalizations.of(context)!.durationSub,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DurationChoice(
                isDarkMode: isDarkMode,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.addServiceLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label: AppLocalizations.of(context)!.durationSub,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AddServiceChoice(
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextLabel(
                label: AppLocalizations.of(context)!.optionLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: PetChoice(
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: NoticeStep1(
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const ButtonNextStep1(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}