import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_app_bar.dart';
import 'package:rmservice/shopping/cubits/save_address.dart';
import 'package:rmservice/shopping/views/maps.dart';
import 'package:rmservice/shopping/widgets/method1_shopping_button.dart';
import 'package:rmservice/utilities/components/show_address.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShoppingStep2Screen extends StatefulWidget {
  const ShoppingStep2Screen({super.key});

  @override
  State<ShoppingStep2Screen> createState() => _ShoppingStep2ScreenState();
}

class _ShoppingStep2ScreenState extends State<ShoppingStep2Screen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ButtonChooseLocation(
          nameLocation: context.watch<SaveAddressShoppingCubit>().state ==
                      null ||
                  context
                          .watch<SaveAddressShoppingCubit>()
                          .state!
                          .nameAddress ==
                      ""
              ? "Vui lòng chọn địa điểm"
              : context.watch<SaveAddressShoppingCubit>().state!.nameAddress!,
          addressLocation: context.watch<SaveAddressShoppingCubit>().state ==
                      null ||
                  context
                          .watch<SaveAddressShoppingCubit>()
                          .state!
                          .fullAddress ==
                      ""
              ? "Vui lòng chọn địa điểm"
              : context.watch<SaveAddressShoppingCubit>().state!.fullAddress!,
          isDarkMode: isDarkMode,
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return YourAddress();
              },
            );
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     duration: Duration(milliseconds: 400),
            //     type: PageTransitionType.rightToLeftWithFade,
            //     child: ChooseLocationScreen(),
            //   ),
            // );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: ListView(
          children: [
            Method1ShoppingButton(),
            SizedBox(
              height: 30,
            ),
            //Methoad2ShoppingButton()
          ],
        ),
      ),
    );
  }
}
