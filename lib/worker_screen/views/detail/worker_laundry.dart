import 'package:flutter/material.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/history/widgets/laundry/location_info.dart';
import 'package:rmservice/history/widgets/laundry/work_info.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkerLaundry extends StatefulWidget {
  const WorkerLaundry({super.key, required this.order});

  final LaundryHistory order;

  @override
  State<WorkerLaundry> createState() => _WorkerLaundryState();
}

class _WorkerLaundryState extends State<WorkerLaundry> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn - Giặt ủi",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger,
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
                ],
              ),
            ),
            SizedBox(height: 10),
            LocationInfoLaundryHistory(
              isDarkMode: isDarkMode,
              order: widget.order,
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
              child: WorkInfoLaundryHistory(
                isDarkMode: isDarkMode,
                order: widget.order,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 17),
            //   child: TextLabel(
            //     label: 'Phương thức thanh toán',
            //     isDarkMode: isDarkMode,
            //   ),
            // ),
            SizedBox(height: 15),
            ButtonGreenApp(label: "Hủy đơn này", onPressed: null),
            SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}