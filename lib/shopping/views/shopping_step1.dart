import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/shopping/cubits/get_shopping_price/get_shopping_price_cubit.dart';
import 'package:rmservice/shopping/cubits/get_shopping_price/get_shopping_price_state.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/cubits/shopping_price_cubit.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/shopping/views/maps.dart';
import 'package:rmservice/shopping/widgets/list_address.dart';
import 'package:rmservice/shopping/widgets/text_label.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingStep1Screen extends StatefulWidget {
  const ShoppingStep1Screen({super.key});

  @override
  State<ShoppingStep1Screen> createState() => _ShoppingStep1ScreenState();
}

class _ShoppingStep1ScreenState extends State<ShoppingStep1Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.shoppingStep1Title,
          style: TextStyle(fontSize: fontSize.mediumLarger),
        ),
      ),
      body: BlocBuilder<GetShoppingPriceCubit, GetShoppingPriceState>(
          builder: (context, state) {
        if (state is GetShoppingPriceError) {
          return Center(child: Text(state.message));
        }

        if (state is GetShoppingPriceLoading) {
          return Center(
            child: CircularProgressIndicator(color: colorProject.primaryColor),
          );
        }

        if (state is GetShoppingPriceSuccess) {
          context.read<ShoppingPriceCubit>().setPrice(state.shoppingPrice);
          context.read<SaveDataShopping>().setPurchaseFee(state.shoppingPrice.unitPrice);
          debugPrint(context.read<ShoppingPriceCubit>().state.toJson().toString());

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RefreshIndicator(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextLabel(
                      label: AppLocalizations.of(context)!.shoppingStep1Label,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextSubLabel(
                      label:
                          AppLocalizations.of(context)!.shoppingStep1LabelSub,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: ListAddress(),
                  ),
                  SizedBox(height: 20),
                  ButtonGreenApp(
                    label: "Chọn địa điểm khác",
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ChooseLocationScreen(),
                          childCurrent: ShoppingStep1Screen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              onRefresh: () async {
                //delay
                await Future.delayed(const Duration(seconds: 3), () {
                  setState(() {});
                });
              },
            ),
          );
        } else {
          return SizedBox();
        }
      }),
    );

    // floatingActionButton: const ButtonNextStep1(),
    // floatingActionButtonLocation:
    //     FloatingActionButtonLocation.miniCenterFloat,
  }
}
