import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkInfoLaundryHistory extends StatefulWidget {
  const WorkInfoLaundryHistory(
      {super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final LaundryHistory order;

  @override
  State<WorkInfoLaundryHistory> createState() => _WorkInfoLaundryHistoryState();
}

class _WorkInfoLaundryHistoryState extends State<WorkInfoLaundryHistory> {
  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    DateTime orderDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.order.working_date);
    DateTime orderHour =
        new DateFormat("HH:mm:ss").parse(widget.order.working_hour);
    DateTime receiveDate =
        new DateFormat("yyyy-MM-dd").parse(widget.order.receive_date);

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
              "Thời gian nhận đồ",
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
            Text(
              //AppLocalizations.of(context)!.locationDetailLabel,
              "Thời gian trả đồ",
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
                    '${DateFormat.yMMMMEEEEd(locale).format(receiveDate)}',
                    //'${DateFormat.yMMMMEEEEd(locale).format(widget.order.receiveDate!)}, giao trong khoảng từ ${DateFormat.Hm(locale).format(widget.order.receiveTime!.add(Duration(hours: -1)))} tới ${DateFormat.Hm(locale).format(widget.order.receiveTime!)}',
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
            Text(
              //AppLocalizations.of(context)!.locationDetailLabel,
              "Danh sách dịch vụ",
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
                  Icons.local_laundry_service,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.order.clothes != 0)
                      Text(
                        "Quần áo x " + widget.order.clothes.toString() + " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.blanket != 0)
                      Text(
                        "Mền x " + widget.order.blanket.toString() + " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.mosquito != 0)
                      Text(
                        "Mùng chống muỗi x " +
                            widget.order.mosquito.toString() +
                            " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.net != 0)
                      Text(
                        "Lưới x " + widget.order.net.toString() + " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.drap != 0)
                      Text(
                        "Drap x " + widget.order.drap.toString() + " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.topper != 0)
                      Text(
                        "Tấm phủ nệm x " +
                            widget.order.topper.toString() +
                            " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.pillow != 0)
                      Text(
                        "Gối x " + widget.order.pillow.toString() + " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.comple != 0)
                      Text(
                        "Com-lê x " + widget.order.comple.toString() + " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.vietnam_dress != 0)
                      Text(
                        "Áo dài x " +
                            widget.order.vietnam_dress.toString() +
                            " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.wedding_dress != 0)
                      Text(
                        "Áo cưới x " +
                            widget.order.wedding_dress.toString() +
                            " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.order.bleaching != 0)
                      Text(
                        "Tẩy trắng đồ giặt x " +
                            widget.order.bleaching.toString() +
                            " bộ",
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      )
                  ],
                )
              ],
            ),
            if (context.watch<SaveInfoLaundryCubit>().state.note != "")
              SizedBox(height: 5),
            if (context.watch<SaveInfoLaundryCubit>().state.note != "")
              Text(
                //AppLocalizations.of(context)!.locationDetailLabel,
                "Ghi chú cho người làm",
                style: TextStyle(
                  fontSize: fontSize.medium,
                  fontFamily: fontBoldApp,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            if (context.watch<SaveInfoLaundryCubit>().state.note != "")
              SizedBox(height: 5),
            if (context.watch<SaveInfoLaundryCubit>().state.note != "")
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
                      context.watch<SaveInfoLaundryCubit>().state.note,
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
          ],
        ),
      ),
    );
  }
}
