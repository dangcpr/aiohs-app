import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/cleaning_longterm/widgets/work_info_long_term.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../cleaning_hourly/widgets/location_info.dart';
import '../../cleaning_hourly/widgets/method_payment.dart';
import '../../cleaning_hourly/widgets/show_bottom_edit_name_phone.dart';
import '../../utilities/components/text_label.dart';

class CleaningLongTermStep2 extends StatefulWidget {
  const CleaningLongTermStep2({super.key});

  @override
  State<CleaningLongTermStep2> createState() => _CleaningLongTermStep2State();
}

class _CleaningLongTermStep2State extends State<CleaningLongTermStep2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'End Data is: ${context.read<SaveInfoCleaningLongTermCubit>().state.toJson().toString()}');
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Xác nhận và thanh toán',
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
              child: WorkInfoCleaningLongTerm(
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
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
