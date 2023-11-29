import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/history/widgets/shopping/list_product.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class WorkInfoShoppingHistory extends StatefulWidget {
  const WorkInfoShoppingHistory(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final ShoppingHistory order;

  @override
  State<WorkInfoShoppingHistory> createState() =>
      _WorkInfoShoppingHistoryState();
}

class _WorkInfoShoppingHistoryState extends State<WorkInfoShoppingHistory> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime orderDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.order.working_date);
    DateTime orderHour =
        new DateFormat("HH:mm:ss").parse(widget.order.working_hour);
        
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
                    '${DateFormat.yMMMMEEEEd(locale).format(orderDate)}, giao trong khoảng từ ${DateFormat.Hm(locale).format(orderHour.add(Duration(hours: -1)))} tới ${DateFormat.Hm(locale).format(orderHour)}',
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
            if (widget.order.note != "")
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
                      widget.order.note,
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
            ListProductHistory(isRemove: false, listProduct: widget.order.items),
          ],
        ),
      ),
    );
  }
}
