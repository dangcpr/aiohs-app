import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/models/air_conditioning_history.dart';
import 'package:rmservice/history/widgets/air_cond/maid_info.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../../login/cubit/user_cubit.dart';
import '../../cubits/order_cancel/order_cancel_cubit.dart';
import '../../widgets/air_cond/location_info_cleaning_air_cond.dart';
import '../../widgets/air_cond/work_info_cleaning_air_cond.dart';

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
    var userCode = context.read<UserCubit>().state.code;
    var orderCode = widget.order.orderAirCondHistory.code;
    return BlocConsumer<OrderCancelCubit, OrderCancelState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is OrderCancelFailed) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Failed",
            desc: state.message,
            btnOkOnPress: () {},
          ).show();
        }
        if (state is OrderCancelLoading) {
          Center(
            child: CircularProgressIndicator(
              color: colorProject.primaryColor,
            ),
          );
        }
        if (state is OrderCancelSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Success",
            desc: 'Cancel Successfully',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        }
      },
      builder: (context, state) {
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
                SizedBox(height: 15),
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
                widget.order.orderAirCondHistory.status == 'new'
                    ? ButtonGreenApp(
                        label: "Hủy đơn này",
                        onPressed: () {
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
                            btnOkOnPress: () {
                              context
                                  .read<OrderCancelCubit>()
                                  .orderCancel(userCode!, orderCode);
                            },
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                          ).show();
                        })
                    : SizedBox(),

                // Padding(
                //   padding: const EdgeInsets.only(top: 17),
                //   child: TextLabel(
                //     label: 'Phương thức thanh toán',
                //     isDarkMode: isDarkMode,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 17),
                //   child: MethodPaymentCleaningHourly(
                //     isDarkMode: isDarkMode,
                //   ),
                // ),
                SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
