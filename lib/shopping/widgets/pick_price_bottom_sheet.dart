import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/shopping/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/cubits/shopping_price_cubit.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/shopping/cubits/save_price_shopping.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PickPrice extends StatefulWidget {
  const PickPrice({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<PickPrice> createState() => _PickPriceState();
}

class _PickPriceState extends State<PickPrice> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = context.read<SavePriceShopping>().state.toString();
  }
  @override
  Widget build(BuildContext context) {
    var caculateSPriceCubit = context.watch<CalculatePriceShoppingCubit>();

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).viewInsets.top + 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          TextLabel(
            label: AppLocalizations.of(context)!.shoppingPriceDialog,
            isDarkMode: widget.isDarkMode,
          ),
          SizedBox(height: 10),
          TextSubLabel(
            label: AppLocalizations.of(context)!.shoppingPriceDialogSub,
            isDarkMode: widget.isDarkMode,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 55,
            child: TextField(
              //inputFormatters: [ThousandsFormatter()],
              keyboardType: TextInputType.number,
              controller: controller,
              style: TextStyle(
                fontFamily: fontApp,
              ),
              textAlignVertical: TextAlignVertical.top,
              maxLines: null,
              expands: true,
              cursorColor: colorProject.primaryColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                      width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorProject.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Nhập giá tiền",
              ),
              onChanged: (value) {
                debugPrint(value);
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: ButtonGreenApp(
              label: "Xác nhận",
              onPressed: () {
                var number = int.tryParse(controller.text);

                if (number == null) {
                  showDialog(
                    context: context,
                    builder: (_) => DialogWrong(
                      notification: "Vui lòng chỉ nhập số nguyên",
                    ),
                  );
                } else {
                  if (number >= 100000 && number <= 3000000) {
                    Navigator.pop(context, number);
                    context.read<SavePriceShopping>().savePrice(number);
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => DialogWrong(
                        notification:
                            "Vui lòng nhập số tiền từ 100,000 đến 3,000,000 ₫",
                      ),
                    );
                  }
                }

                caculateSPriceCubit.calculatePrice(
                    context.read<SaveDataShopping>().state,
                    context.read<SavePriceShopping>().state);
                debugPrint("Xác nhận số tiền");
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
