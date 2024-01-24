import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/helpers/get_detail.dart';
import 'package:rmservice/history/helpers/get_icon.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CardHistoryOrderCancel extends StatefulWidget {
  const CardHistoryOrderCancel({super.key, required this.order});

  final Order order;

  @override
  State<CardHistoryOrderCancel> createState() => _CardHistoryOrderCancelState();
}

class _CardHistoryOrderCancelState extends State<CardHistoryOrderCancel> {
  NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');
  //state = 0: bình thường
  //state = 1: đang load
  //state = 2: đã load xong
  int state = 0;
  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>();
    DateTime createDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.order.created_at);
    String createDateString =
        new DateFormat("dd-MM-yyyy HH:mm:ss").format(createDate);
    DateTime orderDate = widget.order.working_date != ""
        ? DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.order.working_date)
        : DateTime.now();
    String orderDateString = new DateFormat("dd-MM-yyyy").format(orderDate);
    DateTime orderHour =
        new DateFormat("HH:mm:ss").parse(widget.order.working_hour);
    String orderHourString = new DateFormat("HH:mm").format(orderHour);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorProject.primaryColor),
        ),
        child: ListTile(
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                //circle indicator
                return const PopScope(
                  canPop: true,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorProject.primaryColor,
                    ),
                  ),
                );
              },
            );
            try {
              debugPrint(jsonEncode(widget.order.toJson()));
              switch (widget.order.product_code) {
                case 'CLEAN_ON_DEMAND':
                  getCleaningHourlyDetail(context, userCubit, widget.order);
                  break;
                case 'LAUNDRY':
                  getLaundryDetail(context, userCubit, widget.order);
                  break;
                case 'GROCERY_ASSISTANT':
                  getShoppingDetail(context, userCubit, widget.order);
                  break;
                case 'CLEAN_SUBSCRIPTION':
                  getCleaningLongTermDetail(context, userCubit, widget.order);
                  debugPrint(jsonEncode(widget.order.toJson()));
                  break;
                case 'AIR_CONDITIONING_CLEAN':
                  getCleaningAirCondDetail(context, userCubit, widget.order);
                  debugPrint(jsonEncode(widget.order.toJson()));
                  break;
                case 'HOME_COOKING':
                  getCookingDetail(context, userCubit, widget.order);
                  debugPrint(jsonEncode(widget.order.toJson()));
                  break;
                default:
                  Navigator.pop(context);
                  break;
              }
            } catch (e) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (context) {
                  return DialogWrong(
                    notification: e.toString(),
                  );
                },
              );
            }
          },
          leading: Icon(
            getIcon(widget.order.product_code),
            color: colorProject.primaryColor,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorProject.primaryColor,
          ),
          title: Text(
            widget.order.product_name,
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger,
              color: colorProject.primaryColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Giá trị đơn hàng: ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Text(
                    numberFormat.format(widget.order.order_amount),
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ngày, giờ đặt: ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      createDateString,
                      style: TextStyle(
                        fontFamily: fontApp,
                        fontSize: fontSize.medium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ngày, giờ làm: ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      orderDateString + ' ' + orderHourString,
                      style: TextStyle(
                        fontFamily: fontApp,
                        fontSize: fontSize.medium,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
