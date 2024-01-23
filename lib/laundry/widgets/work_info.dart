import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkInfoLaundry extends StatefulWidget {
  const WorkInfoLaundry({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<WorkInfoLaundry> createState() => _WorkInfoLaundryState();
}

class _WorkInfoLaundryState extends State<WorkInfoLaundry> {
  @override
  Widget build(BuildContext context) {
    var laundryInfo = context.read<SaveInfoLaundryCubit>().state;
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
                    '${DateFormat.yMMMMEEEEd(locale).format(laundryInfo.sendDate!)}, giao trong khoảng từ ${DateFormat.Hm(locale).format(laundryInfo.sendTime!.add(Duration(hours: -1)))} tới ${DateFormat.Hm(locale).format(laundryInfo.sendTime!)}',
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
                    '${DateFormat.yMMMMEEEEd(locale).format(laundryInfo.receiveDate!)}',
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
                    if (laundryInfo.clothes != 0)
                      Text(
                        "Quần áo x " +
                            laundryInfo.clothes.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.blanket != 0)
                      Text(
                        "Mền x " +
                            laundryInfo.blanket.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.mosquito != 0)
                      Text(
                        "Mùng chống muỗi x " +
                            laundryInfo.mosquito.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.net != 0)
                      Text(
                        "Lưới x " +
                            laundryInfo.net.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.drap != 0)
                      Text(
                        "Drap x " +
                            laundryInfo.drap.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.topper != 0)
                      Text(
                        "Tấm phủ nệm x " +
                            laundryInfo.topper.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.pillow != 0)
                      Text(
                        "Gối x " +
                            laundryInfo.pillow.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.comple != 0)
                      Text(
                        "Com-lê x " +
                            laundryInfo.comple.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.vietnamDress != 0)
                      Text(
                        "Áo dài x " +
                            laundryInfo.vietnamDress.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.weedingDress != 0)
                      Text(
                        "Áo cưới x " +
                            laundryInfo.weedingDress.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
                        style: TextStyle(
                          fontSize: fontSize.medium,
                          fontFamily: fontApp,
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    if (laundryInfo.bleaching != 0)
                      Text(
                        "Tẩy trắng đồ giặt x " +
                            laundryInfo.bleaching.toString() +
                            (laundryInfo.price_type == 'LAUNDRY_PRICE_TYPE_KG'
                                ? " kg"
                                : " bộ"),
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
