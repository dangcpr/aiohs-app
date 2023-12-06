import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/air_conditioning_history.dart';
import 'package:rmservice/history/widgets/air_cond/location_info_cleaning_air_cond.dart';
import 'package:rmservice/history/widgets/air_cond/maid_info.dart';
import 'package:rmservice/history/widgets/air_cond/work_info_cleaning_air_cond.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/dialog/dialog.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';

class CleaningAirCondHistoryDetail extends StatefulWidget {
  const CleaningAirCondHistoryDetail({super.key, required this.order});

  final CleaningAirCondHistory order;

  @override
  State<CleaningAirCondHistoryDetail> createState() =>
      _CleaningLongTermHistoryDetailState();
}

class _CleaningLongTermHistoryDetailState
    extends State<CleaningAirCondHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn - Vệ sinh máy lạnh",
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
            HistoryLocationInfoCleaningAirCond(
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
              child: HistoryInfoCleaningAirCond(
                isDarkMode: isDarkMode,
                order: widget.order,
              ),
            ),
            if (widget.order.orderAirCondHistory.maidCode != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: "Thông tin người giúp việc",
                  isDarkMode: isDarkMode,
                ),
              ),
            if (widget.order.orderAirCondHistory.maidCode != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: HistoryMaidInfoAirCond(
                  isDarkMode: isDarkMode,
                  order: widget.order,
                ),
              ),
            if (widget.order.orderAirCondHistory.maidCode == "") SizedBox(height: 15),
            if (widget.order.orderAirCondHistory.maidCode == "")
              ButtonGreenApp(
                  label: "Nhận đơn này",
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                    try {
                      await WorkerController().acceptedOrder(widget.order.orderAirCondHistory.code,
                          context.read<UserCubit>().state.code!);
                      Navigator.pop(context);
                      showCustomDialog(
                          context: context,
                          dialogType: CustomDialogType.SUCCESS,
                          msg: "Bạn đã nhận đơn này",
                          isMultipleButton: false);
                    } catch (e) {
                      Navigator.pop(context);
                      showCustomDialog(
                          context: context,
                          dialogType: CustomDialogType.FAILURE,
                          msg: e.toString(),
                          isMultipleButton: false);
                    }
                  }),
            if (widget.order.orderAirCondHistory.maidCode == context.read<UserCubit>().state.code)
              SizedBox(height: 15),

            if (widget.order.orderAirCondHistory.maidCode == context.read<UserCubit>().state.code)
              ButtonGreenApp(label: "Hủy đơn này", onPressed: null),
            if (widget.order.orderAirCondHistory.maidCode == context.read<UserCubit>().state.code)
              SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
