import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/cubits/get_order_accepted/get_order_accepted_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_accepted/get_order_accepted_state.dart';
import 'package:rmservice/worker_screen/widgets/worker_order_card.dart';

class WorkerOrderAccepted extends StatefulWidget {
  const WorkerOrderAccepted({super.key});

  @override
  State<WorkerOrderAccepted> createState() => _WorkerOrderAcceptedState();
}

class _WorkerOrderAcceptedState extends State<WorkerOrderAccepted> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WorkerGetOrderAcceptedCubit>().initState();
    context
        .read<WorkerGetOrderAcceptedCubit>()
        .getOrderAccepted(context.read<UserCubit>().state.code!);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context
            .read<WorkerGetOrderAcceptedCubit>()
            .getOrderAccepted(context.read<UserCubit>().state.code!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var workerGetOrderAccepted = context.watch<WorkerGetOrderAcceptedCubit>();
    return Container(
      child: workerGetOrderAccepted is WorkerGetOrderAcceptedError
          ? Center(child: Text("Đã có lỗi xảy ra"))
          : RefreshIndicator(
              onRefresh: () async {
                context.read<WorkerGetOrderAcceptedCubit>().initState();
                context
                    .read<WorkerGetOrderAcceptedCubit>()
                    .getOrderAccepted(context.read<UserCubit>().state.code!);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: (workerGetOrderAccepted.orders.isEmpty &&
                        workerGetOrderAccepted.state
                            is WorkerGetOrderAcceptedLoaded)
                    ? WorkerEmptyOrder(
                        title: "Không có đơn đã hủy",
                        desc:
                            "Không có đơn đã hủy bởi bạn và người thuê. Vui lòng thử lại sau.")
                    :  Column(
                  children: [
                    for (int i = 0;
                        i < workerGetOrderAccepted.orders.length;
                        i++)
                      WorkerOrderCard(order: workerGetOrderAccepted.orders[i]),
                    //loading
                    BlocBuilder<WorkerGetOrderAcceptedCubit,
                        WorkerGetOrderAcceptedState>(builder: (context, state) {
                      if (state is WorkerGetOrderAcceptedLoading) {
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
