import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/controllers/history_cancelled.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/history/widgets/laundry/location_info.dart';
import 'package:rmservice/history/widgets/laundry/maid_info.dart';
import 'package:rmservice/history/widgets/laundry/work_info.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/worker_screen/controllers/worker.dart';

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
            if (widget.order.maid_name != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: "Thông tin người giúp việc",
                  isDarkMode: isDarkMode,
                ),
              ),
            if (widget.order.maid_code != "")
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: HistoryMaidInfoLaundry(
                  isDarkMode: isDarkMode,
                  order: widget.order,
                ),
              ),
            if (widget.order.maid_code == "") SizedBox(height: 15),
            if (widget.order.maid_code == "")
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
                              widget.order.code,
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
                                fontFamily: fontBoldApp),
                            desc: e.toString(),
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            },
                          ).show();
                        }
                      },
                    ).show();
                  }),
            if (widget.order.maid_code == context.read<UserCubit>().state.code)
              SizedBox(height: 15),

            if (widget.order.maid_code ==
                    context.read<UserCubit>().state.code &&
                (widget.order.status == "new" ||
                    widget.order.status == 'maid_accepted'))
              ButtonGreenApp(
                  label: "Hủy đơn này",
                  onPressed: () async {
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
                                child: CircularProgressIndicator(
                                    color: colorProject.primaryColor),
                              );
                            });
                        try {
                          await HistoryCancelled().ordersCancelled(
                              context.read<UserCubit>().state.code!,
                              widget.order.code);
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
            if (widget.order.maid_code == context.read<UserCubit>().state.code)
              SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
