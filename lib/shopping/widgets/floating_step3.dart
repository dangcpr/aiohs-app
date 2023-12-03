import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/shopping/cubits/add_items.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_state.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/cubits/save_price_shopping.dart';
import 'package:rmservice/shopping/views/shopping_step3_M1.dart';
import 'package:rmservice/shopping/views/shopping_step4.dart';
import 'package:rmservice/shopping/widgets/pick_price_bottom_sheet.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class FloatingStep3 extends StatefulWidget {
  const FloatingStep3({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<FloatingStep3> createState() => _FloatingStep3State();
}

class _FloatingStep3State extends State<FloatingStep3> {
  @override
  Widget build(BuildContext context) {
    var caculateSPriceCubit = context.watch<CalculatePriceShoppingCubit>();

    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.shoppingCountProduct,
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "${context.watch<AddItemCubit>().state.length} ${AppLocalizations.of(context)!.productLabel}",
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  AppLocalizations.of(context)!.shoppingPrice,
                  style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              ),
              Flexible(
                child: context.watch<AddItemCubit>().state.length != 0
                    ? ButtonGreenApp(
                        label: context.watch<SavePriceShopping>().state == 0
                            ? AppLocalizations.of(context)!.shoppingChoosePrice
                            : NumberFormat.simpleCurrency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(
                                    context.watch<SavePriceShopping>().state),
                        onPressed: () {
                          debugPrint("Chọn số tiền");
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                PickPrice(isDarkMode: widget.isDarkMode),
                          );
                        },
                      )
                    : TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 188, 188, 188))),
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.shoppingEmpty,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontBoldApp,
                            fontSize: fontSize.medium,
                          ),
                        ),
                      ),
              )
            ],
          ),
          const SizedBox(height: 5),
          if (context.watch<AddItemCubit>().state.isEmpty ||
              context.watch<SavePriceShopping>().state == 0)
            Container(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 188, 188, 188))),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.nextLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                  ),
                ),
              ),
            ),
          if (context.watch<AddItemCubit>().state.isNotEmpty &&
              context.watch<SavePriceShopping>().state != 0)
            Container(
              width: double.infinity,
              child: caculateSPriceCubit.state is CalculatePriceShoppingLoading?
                  ? const ElevatedButton(
                      onPressed: null,
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.grey)))
                  : caculateSPriceCubit.state is CalculatePriceShoppingError
                      ? const ElevatedButton(
                          onPressed: null,
                          child: Text("Đã có lỗi xảy ra"),
                        )
                      : ButtonGreenApp(
                          label: AppLocalizations.of(context)!.nextLabel,
                          onPressed: () {
                            debugPrint(context
                                .read<SaveDataShopping>()
                                .state
                                .toString());
                            context
                                .read<SaveDataShopping>()
                                .setItems(context.read<AddItemCubit>().state);
                            debugPrint("Lưu data");
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: Duration(milliseconds: 400),
                                type: PageTransitionType.rightToLeftWithFade,
                                child: ShoppingStep4Screen(),
                                childCurrent: ShoppingStep3Method1Screen(),
                              ),
                            );
                          },
                        ),
            ),
        ],
      ),
    );
  }
}
