import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/order_air_cond/order_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/widgets/work_info.dart';
import 'package:rmservice/home_page/view/home_page.dart';
import 'package:rmservice/utilities/components/text_label.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../cleaning_hourly/widgets/location_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilities/dialog/dialog.dart';
import '../cubit/save_info_air_conditioning_cleaning.dart';
import '../widgets/button_next_step3.dart';
import '../widgets/method_payment.dart';

class AirConditioningCleaningScreenStep3 extends StatefulWidget {
  const AirConditioningCleaningScreenStep3({super.key});

  @override
  State<AirConditioningCleaningScreenStep3> createState() =>
      _AirConditioningCleaningScreenStep3State();
}

class _AirConditioningCleaningScreenStep3State
    extends State<AirConditioningCleaningScreenStep3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SaveInfoAirConditioningCleaningCubit>().confuseListDetails();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return BlocListener<OrderAirCondCubit, OrderAirCondState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is OrderAirCondSuccess) {
          debugPrint('OrderAirCondSuccess');
          Navigator.pop(context);
          context.read<OrderAirCondCubit>().setInit();
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
        }
        if (state is OrderAirCondFailed) {
          debugPrint(state.message);
          Navigator.pop(context);
          context.read<OrderAirCondCubit>().setInit();
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
        }
        if (state is OrderAirCondLoading) {
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
                        // showModalBottomSheet(
                        //   isScrollControlled: true,
                        //   context: context,
                        //   builder: (builder) {
                        //     return BottomEditNamePhone(isDarkMode: isDarkMode);
                        //   },
                        // );
                        print(
                            context.read<SaveAddressCubit>().state?.longitude);
                        print(context.read<SaveAddressCubit>().state?.latitude);
                        print(context.read<SaveAddressCubit>().state?.name);
                        print(context.read<SaveAddressCubit>().state?.phone);
                        print(context
                            .read<SaveAddressCubit>()
                            .state
                            ?.shortAddress);
                        print(context.read<SaveAddressCubit>().state?.address);
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
                child: WorkInfoCleaningAirConditioning(
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
                child: MethodPayment(
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
