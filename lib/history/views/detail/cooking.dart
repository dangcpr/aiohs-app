import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rmservice/history/controllers/completed_and_review.dart';
import 'package:rmservice/history/cubits/get_history_accepted/get_history_accepted_cubit.dart';
import 'package:rmservice/history/models/cooking_history.dart';
import 'package:rmservice/history/widgets/cooking/maid_info.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_long.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../../login/cubit/user_cubit.dart';
import '../../cubits/order_cancel/order_cancel_cubit.dart';
import '../../widgets/cooking/location_info_cooking.dart';
import '../../widgets/cooking/work_info_cooking.dart';

class CookingHistoryDetail extends StatefulWidget {
  const CookingHistoryDetail({super.key, required this.order});

  final CookingHistory order;

  @override
  State<CookingHistoryDetail> createState() => _CookingHistoryDetailState();
}

class _CookingHistoryDetailState extends State<CookingHistoryDetail> {
  double star = 3;
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var userCode = context.read<UserCubit>().state.code;
    var orderCode = widget.order.orderCooking.code;
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
              "Chi tiết đơn - Nấu ăn",
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
                HistoryLocationInfoCooking(
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
                  child: HistoryInfoCooking(
                    isDarkMode: isDarkMode,
                    order: widget.order,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(height: 15),
                if (widget.order.orderCooking.maidCode != "")
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextLabel(
                      label: "Thông tin người giúp việc",
                      isDarkMode: isDarkMode,
                    ),
                  ),
                if (widget.order.orderCooking.maidCode != "")
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: HistoryMaidInfoCooking(
                      isDarkMode: isDarkMode,
                      order: widget.order,
                    ),
                  ),
                widget.order.orderCooking.status == 'new'
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
                SizedBox(height: 15),
                widget.order.orderCooking.status == 'maid_accepted'
                    ? ButtonGreenApp(
                        label: "Hoàn thành đơn",
                        onPressed: () {
                          ratingDialog(isDarkMode, userCode!, orderCode);
                        },
                      )
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
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  void ratingDialog(bool isDarkMode, String userCode, String orderCode) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      btnOkOnPress: () async {
        showDialog(
          context: context,
          builder: (context) => Center(
            child: CircularProgressIndicator(color: colorProject.primaryColor),
          ),
        );
        try {
          await CompletedAndReviewOrder().completedOrder(userCode, orderCode);
          await CompletedAndReviewOrder()
              .reviewOrder(userCode, orderCode, commentController.text, star);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: false,
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            //btnCancelOnPress: () {},
            btnOkOnPress: () {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              context.read<GetHistoryAcceptedCubit>().setInitialAccepted();
              context.read<GetHistoryAcceptedCubit>().getHistoryAccepted(
                    context.read<UserCubit>().state.code!,
                  );
            },
            title: "Hoàn thành đơn thành công",
          ).show();
          // ignore: use_build_context_synchronously
        } catch (e) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: "Có lỗi xảy ra",
            titleTextStyle: TextStyle(
              fontFamily: fontBoldApp,
            ),
            desc: e.toString(),
            descTextStyle: TextStyle(
              fontFamily: fontApp,
            ),
          ).show();
        }
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'Đánh giá người giúp việc',
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
              ),
            ),
            Text(
              'Hãy để lại đánh giá để chúng tôi nâng cao chất lượng người giúp việc',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontApp,
                fontSize: fontSize.medium,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Số sao đánh giá',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.medium,
              ),
            ),
            RatingBar.builder(
              initialRating: star,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  star = rating;
                });
                print(star);
              },
            ),
            SizedBox(height: 15),
            Text(
              'Nhận xét (không bắt buộc)',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.medium,
              ),
            ),
            SizedBox(height: 10),
            TextFieldLong(
              height: 100,
              controller: commentController,
              isDarkMode: isDarkMode,
              hintText: "Nhận xét về người giúp việc",
            )
          ],
        ),
      ),
    ).show();
  }
}
