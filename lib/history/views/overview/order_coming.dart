import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_cubit.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_state.dart';
import 'package:rmservice/history/widgets/card_order.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/components/empty_card.dart';

class HistoryOrderComming extends StatefulWidget {
  const HistoryOrderComming({super.key});

  @override
  State<HistoryOrderComming> createState() => _HistoryOrderCommingState();
}

class _HistoryOrderCommingState extends State<HistoryOrderComming> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<GetHistoryOrderCubit>().setInitial();
    context
        .read<GetHistoryOrderCubit>()
        .getHistory(context.read<UserCubit>().state.code!, 'ORDER_STATUS_NEW');
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context.read<GetHistoryOrderCubit>().getHistory(
            context.read<UserCubit>().state.code!, 'ORDER_STATUS_NEW');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var getHistory = context.watch<GetHistoryOrderCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        getHistory.setInitial();
        getHistory.getHistory(
            context.read<UserCubit>().state.code!, 'ORDER_STATUS_NEW');
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          child: getHistory.state is GetHistoryOrderError
              ? Center(
                  child:
                      Text((getHistory.state as GetHistoryOrderError).message))
              : (getHistory.orders.isEmpty &&
                      getHistory.state is GetHistoryOrderLoaded)
                  ? WorkerEmptyOrder(
                      title: "Không có đơn đang chờ",
                      desc: "Không có đơn đang chờ, vui lòng đặt đơn.",
                    )
                  : Column(
                      children: [
                        for (int i = 0; i < getHistory.orders.length; i++)
                          CardHistoryOrder(order: getHistory.orders[i]),
                        //loading
                        BlocBuilder<GetHistoryOrderCubit, GetHistoryOrderState>(
                            builder: (context, state) {
                          if (state is GetHistoryOrderLoading) {
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
