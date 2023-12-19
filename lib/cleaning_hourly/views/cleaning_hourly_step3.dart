import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/order_cleaning_hourly/order_cleaning_hourly_state.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_next_step3.dart';
import 'package:rmservice/cleaning_hourly/widgets/location_info.dart';
import 'package:rmservice/cleaning_hourly/widgets/method_payment.dart';
import 'package:rmservice/cleaning_hourly/widgets/show_bottom_edit_name_phone.dart';
import 'package:rmservice/home_page/view/home_page.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/cleaning_hourly/widgets/work_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CleaningHourlyStep3Screen extends StatefulWidget {
  const CleaningHourlyStep3Screen({super.key});

  @override
  State<CleaningHourlyStep3Screen> createState() =>
      _CleaningHourlyStep3ScreenState();
}

class _CleaningHourlyStep3ScreenState extends State<CleaningHourlyStep3Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return BlocListener<OrderCleaningHourlyCubit, OrderCleaningHourlyState>(
      listener: (context, state) {
        if (state is OrderCleaningHourlySuccess) {
          debugPrint('OrderCleaningHourlySuccess');
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            title: "Đặt đơn thành công",
            btnOkText: "Trở lại màn hình chính",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: HomePage(),
                ),
                (route) => false,
              );
            },
          ).show();
          context.read<OrderCleaningHourlyCubit>().setInit();
        }
        if (state is OrderCleaningHourlyError) {
          debugPrint(state.message);
          Navigator.pop(context);
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            title: "Có lỗi xảy ra",
            desc: state.message,
            btnOkText: "Trở lại màn hình chính",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  duration: Duration(milliseconds: 400),
                  type: PageTransitionType.rightToLeftWithFade,
                  child: HomePage(),
                ),
                (route) => false,
              );
            },
          ).show();
          context.read<OrderCleaningHourlyCubit>().setInit();
        }
        if (state is OrderCleaningHourlyLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return PopScope(
                canPop: false,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: colorProject.primaryColor,
                  ),
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
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
                child: WorkInfoCleaningHourly(
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
      ),
    );
  }
}
