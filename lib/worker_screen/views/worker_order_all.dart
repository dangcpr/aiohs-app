import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_state.dart';
import 'package:rmservice/worker_screen/widgets/worker_order_card.dart';

class WorkerOrderAll extends StatefulWidget {
  const WorkerOrderAll({super.key});

  @override
  State<WorkerOrderAll> createState() => _WorkerOrderAllState();
}

class _WorkerOrderAllState extends State<WorkerOrderAll> {
  double distance = 5;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WorkerGetOrderAllCubit>().reset();
    context
        .read<WorkerGetOrderAllCubit>()
        .getOrderAll(distance, context.read<UserCubit>().state.code!);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context
            .read<WorkerGetOrderAllCubit>()
            .getOrderAll(distance, context.read<UserCubit>().state.code!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    var workerGetOrderAll = context.watch<WorkerGetOrderAllCubit>();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Bộ lọc đơn hàng",
                style: TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                    color: colorProject.primaryColor),
              ),
              // Text(
              //   distance.toString() + " km",
              //   style: TextStyle(
              //     fontFamily: fontBoldApp,
              //     fontSize: fontSize.medium,
              //   ),
              // ),
              SizedBox(width: 5),
              InkWell(
                child: Icon(
                  Icons.filter_list,
                  color: colorProject.primaryColor,
                  size: 30,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: filter(isDarkMode),
                      );
                    },
                  );
                },
              ),
              SizedBox(width: 5),
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<WorkerGetOrderAllCubit>().reset();
                context.read<WorkerGetOrderAllCubit>().getOrderAll(
                    distance, context.read<UserCubit>().state.code!);
              },
              child: workerGetOrderAll.state is WorkerGetOrderAllError
                  ? Center(child: Text("Đã có lỗi xảy ra"))
                  : SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      child: (workerGetOrderAll.orders.isEmpty &&
                              workerGetOrderAll.state
                                  is WorkerGetOrderAllLoaded)
                          ? WorkerEmptyOrder(
                              title: "Không có đơn gần đây",
                              desc:
                                  "Không có đơn gần đây. Vui lòng thay đổi địa chỉ mặc định")
                          : Column(
                              children: [
                                for (int i = 0;
                                    i < workerGetOrderAll.orders.length;
                                    i++)
                                  WorkerOrderCard(
                                      order: workerGetOrderAll.orders[i]),
                                //loading
                                BlocBuilder<WorkerGetOrderAllCubit,
                                        WorkerGetOrderAllState>(
                                    builder: (context, state) {
                                  if (state is WorkerGetOrderAllLoading) {
                                    return Align(
                                      alignment: FractionalOffset.topCenter,
                                      child: CircularProgressIndicator(
                                        color: colorProject.primaryColor,
                                      ),
                                    );
                                  }
                                  return Container();
                                }),
                              ],
                            ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filter(bool isDarkMode) {
    TextEditingController controller = TextEditingController();
    controller.text = distance.toString();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextLabel(label: "Bộ lọc đơn hàng", isDarkMode: isDarkMode),
          SizedBox(height: 20),
          TextFieldBasic(
            controller: controller,
            isDarkMode: isDarkMode,
            hintText: "Khoảng cách (km)",
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: ButtonGreenApp(
              label: "Đồng ý",
              onPressed: () {
                if (double.tryParse(controller.text) == null ||
                    double.tryParse(controller.text)! <= 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogWrong(
                        notification: "Khoảng cách phải là số và lớn hơn không",
                      );
                    },
                  );
                } else {
                  setState(() {
                    distance = double.tryParse(controller.text)!;
                  });
                  Navigator.pop(context);
                  context.read<WorkerGetOrderAllCubit>().reset();
                  context.read<WorkerGetOrderAllCubit>().getOrderAll(
                      distance, context.read<UserCubit>().state.code!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  
}
