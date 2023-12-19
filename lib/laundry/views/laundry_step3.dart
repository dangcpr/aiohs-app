import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/home_page/view/home_page.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/order_laundry/order_laundry_state.dart';
import 'package:rmservice/laundry/widgets/button/button_next_step3.dart';
import 'package:rmservice/laundry/widgets/location_info.dart';
import 'package:rmservice/laundry/widgets/method_payment.dart';
import 'package:rmservice/laundry/widgets/work_info.dart';
import 'package:rmservice/shopping/widgets/show_bottom_edit_name_phone.dart';
import 'package:rmservice/utilities/components/text_label.dart';

import '../../utilities/constants/variable.dart';

class LaundryStep3Screen extends StatefulWidget {
  const LaundryStep3Screen({super.key});

  @override
  State<LaundryStep3Screen> createState() => _LaundryStep3ScreenState();
}

class _LaundryStep3ScreenState extends State<LaundryStep3Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return BlocListener<OrderLaundryCubit, OrderLaundryState>(
      listener: (context, state) {
        if (state is OrderLaundrySuccess) {
          debugPrint('OrderLaundrySuccess');
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
          context.read<OrderLaundryCubit>().setInit();
        }
        if (state is OrderLaundryError) {
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
          context.read<OrderLaundryCubit>().setInit();
        }
        if (state is OrderLaundryLoading) {
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
              LocationInfoLaundry(
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
                child: WorkInfoLaundry(
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
                child: MethodPaymentLaundry(
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
        floatingActionButton: ButtonNextStep3Laundry(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
