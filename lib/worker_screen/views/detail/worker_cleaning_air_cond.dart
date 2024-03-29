// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/controllers/history_cancelled.dart';
import 'package:rmservice/history/models/air_conditioning_history.dart';
import 'package:rmservice/history/widgets/air_cond/location_info_cleaning_air_cond.dart';
import 'package:rmservice/history/widgets/air_cond/maid_info.dart';
import 'package:rmservice/history/widgets/air_cond/work_info_cleaning_air_cond.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
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
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');

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
        padding: const EdgeInsets.only(left: 20, right: 20),
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
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tổng giá tiền: ${numberFormat.format(widget.order.orderAirCondHistory.orderAmount)}',
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              ],
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
            if (widget.order.orderAirCondHistory.maidCode == "")
              SizedBox(height: 15),
            if (widget.order.orderAirCondHistory.maidCode == "")
              ButtonGreenApp(
                label: "Nhận đơn này",
                onPressed: () async {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.topSlide,
                    titleTextStyle: TextStyle(
                      color: Colors.orange,
                      fontSize: fontSize.large,
                      fontFamily: fontBoldApp,
                    ),
                    showCloseIcon: true,
                    title: "Cảnh báo",
                    desc: 'Bạn có chắc muốn nhận đơn?',
                    btnOkOnPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: colorProject.primaryColor,
                              ),
                            );
                          });
                      try {
                        await WorkerController().acceptedOrder(
                            widget.order.orderAirCondHistory.code,
                            context.read<UserCubit>().state.code!);
                        Navigator.pop(context);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          title: "Nhận đơn thành công",
                          btnOkOnPress: () {
                            Navigator.pop(context);
                          },
                        ).show();
                      } catch (e) {
                        Navigator.pop(context);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          title: "Có lỗi xảy ra",
                          titleTextStyle: TextStyle(
                            color: Colors.red,
                            fontSize: fontSize.large,
                            fontFamily: fontBoldApp,
                          ),
                          desc: e.toString(),
                          btnOkOnPress: () {
                            Navigator.pop(context);
                          },
                        ).show();
                      }
                    },
                  ).show();
                },
              ),
            if (widget.order.orderAirCondHistory.maidCode ==
                context.read<UserCubit>().state.code)
              SizedBox(height: 15),
            if (widget.order.orderAirCondHistory.maidCode ==
                    context.read<UserCubit>().state.code &&
                (widget.order.orderAirCondHistory.status == "new" ||
                    (widget.order.orderAirCondHistory.status ==
                            'maid_accepted' &&
                        widget.order.orderAirCondHistory.paymentMethod ==
                            "cash")))
              ButtonGreenApp(
                  label: "Hủy đơn này",
                  onPressed: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      titleTextStyle: TextStyle(
                        color: Colors.orange,
                        fontSize: fontSize.mediumLarger,
                      ),
                      showCloseIcon: true,
                      title: "Cảnh báo",
                      desc: 'Bạn có chắc muốn hủy đơn?',
                      btnOkOnPress: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: colorProject.primaryColor),
                            );
                          },
                        );
                        try {
                          await HistoryCancelled().ordersCancelled(
                              context.read<UserCubit>().state.code!,
                              widget.order.orderAirCondHistory.code);
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
            if (widget.order.orderAirCondHistory.maidCode ==
                context.read<UserCubit>().state.code)
              SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
