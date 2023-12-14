import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/controllers/history_cancelled.dart';
import 'package:rmservice/history/models/cleaning_longterm_history.dart';
import 'package:rmservice/history/widgets/cleaning_longterm/location_info_cleaning_longterm.dart';
import 'package:rmservice/history/widgets/cleaning_longterm/maid_info.dart';
import 'package:rmservice/history/widgets/cleaning_longterm/work_info_cleaning_longterm.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/dialog/dialog.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';

class CleaningLongTermHistoryDetail extends StatefulWidget {
  const CleaningLongTermHistoryDetail({super.key, required this.order});

  final CleaningLongTermHistory order;

  @override
  State<CleaningLongTermHistoryDetail> createState() =>
      _CleaningLongTermHistoryDetailState();
}

class _CleaningLongTermHistoryDetailState
    extends State<CleaningLongTermHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn - Giúp việc dài hạn",
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
            HistoryLocationInfoCleaningLongTerm(
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
              child: HistoryInfoCleaningLongTerm(
                isDarkMode: isDarkMode,
                order: widget.order,
              ),
            ),
            if (widget.order.orderCleaningLongTerm.maidCode != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: "Thông tin người giúp việc",
                  isDarkMode: isDarkMode,
                ),
              ),
            if (widget.order.orderCleaningLongTerm.maidCode != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: HistoryMaidInfoCleaningLongTerm(
                  isDarkMode: isDarkMode,
                  order: widget.order,
                ),
              ),
            if (widget.order.orderCleaningLongTerm.maidCode == "")
              SizedBox(height: 15),
            if (widget.order.orderCleaningLongTerm.maidCode == "")
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
                      await WorkerController().acceptedOrder(
                          widget.order.orderCleaningLongTerm.code,
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
            if (widget.order.orderCleaningLongTerm.maidCode ==
                context.read<UserCubit>().state.code)
              SizedBox(height: 15),
            if (widget.order.orderCleaningLongTerm.maidCode ==
                    context.read<UserCubit>().state.code &&
                (widget.order.orderCleaningLongTerm.status == "new" || widget.order.orderCleaningLongTerm.status == 'maid_accepted'))
              ButtonGreenApp(label: "Hủy đơn này", onPressed: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      titleTextStyle: TextStyle(
                        color: Colors.orange,
                      ),
                      showCloseIcon: true,
                      title: "Cảnh báo",
                      desc: 'Bạn có chắc muốn hủy đơn?',
                      btnOkOnPress: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(color: colorProject.primaryColor),
                            );
                          }
                        );
                        try {
                        await HistoryCancelled().ordersCancelled(
                            context.read<UserCubit>().state.code!,
                            widget.order.orderCleaningLongTerm.code);
                          Navigator.pop(context);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            title: "Hủy đơn thành công",
                          ).show();
                        } catch (e) {
                          Navigator.pop(context);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.topSlide,
                            title: "Hủy đơn thất bại",
                            desc: e.toString(),
                          ).show();
                        }
                      },
                      btnCancelOnPress: () {
                        Navigator.pop(context);
                      },
                    ).show();
                  }),
            if (widget.order.orderCleaningLongTerm.maidCode ==
                context.read<UserCubit>().state.code)
              SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
