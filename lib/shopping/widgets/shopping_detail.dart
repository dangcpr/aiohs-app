import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/widgets/list_product.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShoppingDetail extends StatefulWidget {
  const ShoppingDetail({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<ShoppingDetail> createState() => _ShoppingDetailState();
}

class _ShoppingDetailState extends State<ShoppingDetail> {
  @override
  Widget build(BuildContext context) {
    final shoppingInfo = context.read<SaveDataShopping>().state;
    String locale = Localizations.localeOf(context).languageCode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(172, 172, 172, 172), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              //AppLocalizations.of(context)!.locationDetailLabel,
              "Thời gian giao hàng",
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontBoldApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.calendar_today_sharp,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    //context.watch<SaveAddressShoppingCubit>().state!.yourName!,
                    '${DateFormat.yMMMMEEEEd(locale).format(shoppingInfo.date!)}, giao trong khoảng từ ${DateFormat.Hm(locale).format(shoppingInfo.time!.add(Duration(hours: -1)))} tới ${DateFormat.Hm(locale).format(shoppingInfo.time!)}',
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            if (context.watch<SaveDataShopping>().state.note! != "")
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notes,
                    color: colorProject.primaryColor,
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      //context.watch<SaveAddressShoppingCubit>().state!.phoneNum!,
                      context.watch<SaveDataShopping>().state.note!,
                      style: TextStyle(
                        fontSize: fontSize.medium,
                        fontFamily: fontApp,
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 10),
            Text(
              //AppLocalizations.of(context)!.locationDetailLabel,
              "Danh sách sản phẩm cần mua",
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontBoldApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            ListProduct(isRemove: false),
          ],
        ),
      ),
    );
  }
}
