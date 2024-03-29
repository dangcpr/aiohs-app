import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/cubits/get_history_accepted/get_history_accepted_cubit.dart';
import 'package:rmservice/history/cubits/get_history_accepted/get_history_accepted_state.dart';
import 'package:rmservice/history/widgets/card_order.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/components/empty_card.dart';

class HistoryOrderReceived extends StatefulWidget {
  const HistoryOrderReceived({super.key});

  @override
  State<HistoryOrderReceived> createState() => _HistoryOrderReceivedState();
}

class _HistoryOrderReceivedState extends State<HistoryOrderReceived> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetHistoryAcceptedCubit>();
    cubit.setInitialAccepted();
    cubit.getHistoryAccepted(context.read<UserCubit>().state.code!);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        cubit.getHistoryAccepted(context.read<UserCubit>().state.code!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var getHistory = context.watch<GetHistoryAcceptedCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        getHistory.setInitialAccepted();
        getHistory.getHistoryAccepted(context.read<UserCubit>().state.code!);
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          child: getHistory.state is GetHistoryAcceptedError
              ? Center(child: Text((getHistory.state as GetHistoryAcceptedError).message))
              : (getHistory.ordersAccepted.isEmpty &&
                      getHistory.state is GetHistoryAcceptedLoaded)
                  ? WorkerEmptyOrder(
                      title: "Không có đơn đã có giúp việc",
                      desc:
                          "Không có đơn đã có giúp việc, vui lòng thử lại sau.",
                    )
                  : Column(
                      children: [
                        for (int i = 0;
                            i < getHistory.ordersAccepted.length;
                            i++)
                          CardHistoryOrder(order: getHistory.ordersAccepted[i]),
                        //loading
                        BlocBuilder<GetHistoryAcceptedCubit,
                            GetHistoryAcceptedState>(
                          builder: (context, state) {
                            if (state is GetHistoryAcceptedLoading) {
                              return Align(
                                alignment: FractionalOffset.topCenter,
                                child: CircularProgressIndicator(
                                  color: colorProject.primaryColor,
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
