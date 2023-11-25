import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/widgets/work_info.dart';

import '../../cleaning_hourly/widgets/location_info.dart';
import '../../cleaning_hourly/widgets/method_payment.dart';
import '../../cleaning_hourly/widgets/show_bottom_edit_name_phone.dart';
import '../../cleaning_hourly/widgets/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/save_info_air_conditioning_cleaning.dart';
import '../widgets/button_next_step3.dart';

class AirConditioningCleaningScreenStep3 extends StatefulWidget {
  const AirConditioningCleaningScreenStep3({super.key});

  @override
  State<AirConditioningCleaningScreenStep3> createState() =>
      _AirConditioningCleaningScreenStep3State();
}

class _AirConditioningCleaningScreenStep3State
    extends State<AirConditioningCleaningScreenStep3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cubit = context.read<SaveInfoAirConditioningCleaningCubit>();
    print('End data: ${cubit.state.details.length}');
    print('End data: ${cubit.state.time}');
    print('End data: ${cubit.state.note}');
    print('End data: ${cubit.state.date}');
    print('End data: ${cubit.state.duration}');
  }

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
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextLabel(
                      label: AppLocalizations.of(context)!.locationLabel,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => colorProject.primaryColor,
                      ),
                    ),
                    icon: Icon(color: Colors.white, Icons.edit),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (builder) {
                          return BottomEditNamePhone(isDarkMode: isDarkMode);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            LocationInfoCleaningHourly(
              isDarkMode: isDarkMode,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.workingInfoLabel,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: WorkInfoCleaningAirConditioning(
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: 'Phương thức thanh toán',
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: MethodPaymentCleaningHourly(
                isDarkMode: isDarkMode,
              ),
            ),
            SizedBox(height: 8)
          ],
        ),
      ),
      floatingActionButton: ButtonNextStep3(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
