import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/cubits/get_order_completed/get_order_completed_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_completed/get_order_completed_state.dart';
import 'package:rmservice/worker_screen/widgets/worker_order_card.dart';

class WorkerOrderCompleted extends StatefulWidget {
  const WorkerOrderCompleted({super.key});

  @override
  State<WorkerOrderCompleted> createState() => _WorkerOrderCompletedState();
}

class _WorkerOrderCompletedState extends State<WorkerOrderCompleted> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WorkerGetOrderCompletedCubit>().initState();
    context
        .read<WorkerGetOrderCompletedCubit>()
        .getOrderCompleted(context.read<UserCubit>().state.code!);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context
            .read<WorkerGetOrderCompletedCubit>()
            .getOrderCompleted(context.read<UserCubit>().state.code!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var workerGetOrder = context.watch<WorkerGetOrderCompletedCubit>();
    return Container(
      child: workerGetOrder.state is WorkerGetOrderCompletedError
          ? Center(child: Text("Đã có lỗi xảy ra"))
          : RefreshIndicator(
              onRefresh: () async {
                context.read<WorkerGetOrderCompletedCubit>().initState();
                context
                    .read<WorkerGetOrderCompletedCubit>()
                    .getOrderCompleted(context.read<UserCubit>().state.code!);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: (workerGetOrder.orders.isEmpty &&
                        workerGetOrder.state
                            is WorkerGetOrderCompletedLoaded)
                    ? WorkerEmptyOrder(
                        title: "Không có đơn đã hoàn thành",
                        desc:
                            "Không có đơn đã hoàn thành. Vui lòng thử lại sau.")
                    : Column(
                        children: [
                          for (int i = 0;
                              i < workerGetOrder.orders.length;
                              i++)
                            WorkerOrderCard(
                                order: workerGetOrder.orders[i]),
                          //loading
                          BlocBuilder<WorkerGetOrderCompletedCubit,
                                  WorkerGetOrderCompletedState>(
                              builder: (context, state) {
                            if (state is WorkerGetOrderCompletedLoading) {
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