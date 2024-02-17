import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_state.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_state.dart';

import '../../history/cubits/get_history_order.dart/get_history_order_cubit.dart';
import '../../history/helpers/get_icon.dart';
import '../../login/cubit/user_cubit.dart';
import '../../shopping/widgets/dialog_wrong.dart';
import '../../worker_screen/cubits/get_order_all/get_order_all_cubit.dart';
import '../../worker_screen/helpers/get_data_worker.dart';
import '../../worker_screen/views/worker_screen.dart';

class HintJob extends StatefulWidget {
  const HintJob({super.key});

  @override
  State<HintJob> createState() => _HintJobState();
}

class _HintJobState extends State<HintJob> {
  void initState() {
    super.initState();
    context.read<WorkerGetOrderAllCubit>().getOrderAll(
          context.read<UserCubit>().state.code!,
          productCode: 'PRODUCT_CODE_UNSPECIFIED',
          distance: 10,
        );
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');
    var workerGetOrderAll = context.watch<WorkerGetOrderAllCubit>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<WorkerGetOrderAllCubit, WorkerGetOrderAllState>(
        builder: (context, state) {
          if (state is WorkerGetOrderAllLoading) {
            return Align(
              alignment: FractionalOffset.topCenter,
              child: CircularProgressIndicator(
                color: colorProject.primaryColor,
              ),
            );
          }
          if (state is WorkerGetOrderAllError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is WorkerGetOrderAllLoaded) {
            return state.orders.isEmpty
                ? Center(
                    child: Text('Không có đơn hàng gợi ý'),
                  )
                : state.orders.length <= 4
                    ? Row(
                        children: [
                          for (var item in state.orders)
                            itemCard(
                              title: item.product_name,
                              address: item.working_address,
                              price: numberFormat.format(item.order_amount),
                              productCode: item.product_code,
                              order: item,
                            ),
                        ],
                      )
                    : Row(
                        children: [
                          for (var i = 0; i < 4; i++)
                            itemCard(
                              title: state.orders[i].product_name,
                              address: state.orders[i].working_address,
                              price: numberFormat
                                  .format(state.orders[i].order_amount),
                              productCode: state.orders[i].product_code,
                              order: state.orders[i],
                            ),
                          Container(
                            width: 180,
                            height: 230,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.25),
                                      spreadRadius: 1,
                                      blurRadius: 2)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Xem thêm',
                                    style: TextStyle(
                                      fontFamily: fontBoldApp,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration:
                                                Duration(milliseconds: 400),
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: WorkerScreen(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
          }
          return Container();
        },
      ),
    );
  }

  Widget itemCard(
      {required var title,
      required var address,
      required var price,
      required var order,
      required var productCode}) {
    var userCubit = context.read<UserCubit>();
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        height: 230,
        decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  color: Theme.of(context).primaryColor.withOpacity(.25),
                  spreadRadius: 1,
                  blurRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(getIcon(productCode), height: 50),
              Text(
                title,
                style: TextStyle(fontFamily: fontBoldApp, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6),
              Text(
                'Địa chỉ: $address',
                style: TextStyle(
                  fontFamily: fontApp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontFamily: fontApp,
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
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
                        switch (productCode) {
                          case 'CLEAN_ON_DEMAND':
                            WorkerHelper().getCleaningHourlyDetail(
                                context, userCubit, order);
                            break;
                          case 'LAUNDRY':
                            WorkerHelper()
                                .getLaundryDetail(context, userCubit, order);
                            break;
                          case 'GROCERY_ASSISTANT':
                            WorkerHelper()
                                .getShoppingDetail(context, userCubit, order);
                            break;
                          case 'CLEAN_SUBSCRIPTION':
                            WorkerHelper().getCleaningLongTermDetail(
                                context, userCubit, order);
                            break;
                          case 'AIR_CONDITIONING_CLEAN':
                            WorkerHelper().getCleaningAirCondDetail(
                                context, userCubit, order);
                            break;
                          case 'HOME_COOKING':
                            WorkerHelper()
                                .getCookingDetail(context, userCubit, order);
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
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
