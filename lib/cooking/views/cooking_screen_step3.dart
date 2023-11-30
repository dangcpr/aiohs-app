import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cooking/cubit/order_cooking/order_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/cooking/widgets/method_payment_cooking.dart';
import 'package:rmservice/cooking/widgets/work_info_cooking.dart';
import 'package:rmservice/shopping/widgets/text_label.dart';

import '../../cleaning_hourly/widgets/location_info.dart';
import '../../cleaning_hourly/widgets/method_payment.dart';
import '../../cleaning_hourly/widgets/show_bottom_edit_name_phone.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilities/dialog/dialog.dart';
import '../widgets/button_next_step3.dart';

class CookingScreenStep3 extends StatefulWidget {
  const CookingScreenStep3({super.key});

  @override
  State<CookingScreenStep3> createState() => _CookingScreenStep3State();
}

class _CookingScreenStep3State extends State<CookingScreenStep3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cubit = context.read<SaveInfoCookingCubit>().state;
    print(cubit.toJson().toString());
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return BlocListener<OrderCookingCubit, OrderCookingState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is OrderCookingSuccess) {
          debugPrint('OrderCleaningLongTermSuccess');
          Navigator.pop(context);
          context.read<OrderCookingCubit>().setInit();
          showCustomDialog(
            context: context,
            dialogType: CustomDialogType.SUCCESS,
            msg: 'Order SuccessFully',
            isMultipleButton: false,
          );
        }
        if (state is OrderCookingFailed) {
          debugPrint(state.message);
          Navigator.pop(context);
          context.read<OrderCookingCubit>().setInit();
          showCustomDialog(
            context: context,
            dialogType: CustomDialogType.FAILURE,
            msg: state.message,
            isMultipleButton: false,
          );
        }
        if (state is OrderCookingLoading) {
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
                child: WorkInfoCooking(
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
                child: MethodPaymentCooking(
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
