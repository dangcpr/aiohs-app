import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/order_air_cond/order_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/widgets/work_info.dart';
import 'package:rmservice/utilities/components/text_label.dart';

import '../../cleaning_hourly/widgets/location_info.dart';
import '../../cleaning_hourly/widgets/method_payment.dart';
import '../../cleaning_hourly/widgets/show_bottom_edit_name_phone.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilities/components/dialog_wrong.dart';
import '../../utilities/dialog/dialog.dart';
import '../../utilities/indicator/custom_progress_indicator.dart';
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
          showCustomDialog(
            context: context,
            dialogType: CustomDialogType.SUCCESS,
            msg: 'Order SuccessFully',
            isMultipleButton: false,
          );
        }
        if (state is OrderAirCondFailed) {
          debugPrint(state.message);
          Navigator.pop(context);
          context.read<OrderAirCondCubit>().setInit();
          showCustomDialog(
            context: context,
            dialogType: CustomDialogType.FAILURE,
            msg: state.message.toString(),
            isMultipleButton: false,
          );
        }
        if (state is OrderAirCondLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return PopScope(
                canPop: false,
                child: AlertDialog(
                  content: Container(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: colorProject.primaryColor,
                      ),
                    ),
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
