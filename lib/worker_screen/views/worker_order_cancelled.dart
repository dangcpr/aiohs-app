import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/cubits/get_order_cancelled/get_order_cancelled_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_cancelled/get_order_cancelled_state.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/worker_screen/widgets/worker_order_card.dart';

class WorkerOrderCancelled extends StatefulWidget {
  const WorkerOrderCancelled({super.key});

  @override
  State<WorkerOrderCancelled> createState() => _WorkerOrderCancelledState();
}

class _WorkerOrderCancelledState extends State<WorkerOrderCancelled> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WorkerGetOrderCancelledCubit>().initState();
    context
        .read<WorkerGetOrderCancelledCubit>()
        .getOrderCancelled(context.read<UserCubit>().state.code!);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context
            .read<WorkerGetOrderCancelledCubit>()
            .getOrderCancelled(context.read<UserCubit>().state.code!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var workerGetOrderAccepted = context.watch<WorkerGetOrderCancelledCubit>();
    return Container(
      child: workerGetOrderAccepted.state is WorkerGetOrderCancelledError
          ? Center(child: Text("Đã có lỗi xảy ra"))
          : RefreshIndicator(
              onRefresh: () async {
                context.read<WorkerGetOrderCancelledCubit>().initState();
                context
                    .read<WorkerGetOrderCancelledCubit>()
                    .getOrderCancelled(context.read<UserCubit>().state.code!);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: (workerGetOrderAccepted.orders.isEmpty &&
                        workerGetOrderAccepted.state
                            is WorkerGetOrderCancelledLoaded)
                    ? WorkerEmptyOrder(
                        title: "Không có đơn đã hủy",
                        desc:
                            "Không có đơn đã hủy bởi bạn và người thuê. Vui lòng thử lại sau.")
                    : Column(
                        children: [
                          for (int i = 0;
                              i < workerGetOrderAccepted.orders.length;
                              i++)
                            WorkerOrderCard(
                                order: workerGetOrderAccepted.orders[i]),
                          //loading
                          BlocBuilder<WorkerGetOrderCancelledCubit,
                                  WorkerGetOrderCancelledState>(
                              builder: (context, state) {
                            if (state is WorkerGetOrderCancelledLoading) {
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
    );
  }
}
