import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/home_page/view/home_page.dart';
import 'package:rmservice/shopping/cubits/order_shopping/order_shopping_cubit.dart';
import 'package:rmservice/shopping/cubits/order_shopping/order_shopping_state.dart';
import 'package:rmservice/shopping/widgets/floating_step5.dart';
import 'package:rmservice/shopping/widgets/location_info.dart';
import 'package:rmservice/shopping/widgets/method_payment.dart';
import 'package:rmservice/shopping/widgets/shopping_detail.dart';
import 'package:rmservice/shopping/widgets/show_bottom_edit_name_phone.dart';
import 'package:rmservice/shopping/widgets/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShoppingStep5Screen extends StatefulWidget {
  const ShoppingStep5Screen({super.key});

  @override
  State<ShoppingStep5Screen> createState() => _ShoppingStep5ScreenState();
}

class _ShoppingStep5ScreenState extends State<ShoppingStep5Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return BlocListener<OrderShoppingCubit, OrderShoppingState>(
      listener: (context, state) {
        if (state is OrderShoppingSuccess) {
          debugPrint('OrderShoppingSuccess');
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
          context.read<OrderShoppingCubit>().setInit();
        }
        if (state is OrderShoppingError) {
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
          context.read<OrderShoppingCubit>().setInit();
        }
        if (state is OrderShoppingLoading) {
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
              LocationInfoShopping(
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
                child: ShoppingDetail(
                  isDarkMode: isDarkMode,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 17),
              //   child: WorkInfoCleaningHourly(
              //     isDarkMode: isDarkMode,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: 'Phương thức thanh toán',
                  isDarkMode: isDarkMode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: MethodPaymentShopping(
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(height: 8)
            ],
          ),
        ),
        floatingActionButton: FloatingStep5(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    );
  }
}
