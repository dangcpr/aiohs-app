import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/cubits/get_history_completed/get_history_completed_cubit.dart';
import 'package:rmservice/history/cubits/get_history_completed/get_history_completed_state.dart';
import 'package:rmservice/history/widgets/card_order.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/components/empty_card.dart';

class HistoryOrderCompleted extends StatefulWidget {
  const HistoryOrderCompleted({super.key});

  @override
  State<HistoryOrderCompleted> createState() => _HistoryOrderCompletedState();
}

class _HistoryOrderCompletedState extends State<HistoryOrderCompleted> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetHistoryCompletedCubit>();
    cubit.setInitialCompleted();
    cubit.getHistoryCompleted(context.read<UserCubit>().state.code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<GetHistoryCompletedCubit, GetHistoryOrderCompletedState>(
            builder: (context, state) {
      if (state is GetHistoryOrderCompletedLoading) {
        return Align(
          alignment: FractionalOffset.topCenter,
          child: CircularProgressIndicator(
            color: colorProject.primaryColor,
          ),
        );
      }

      if (state is GetHistoryOrderCompletedLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<GetHistoryCompletedCubit>().setInitialCompleted();
            await context
                .read<GetHistoryCompletedCubit>()
                .getHistoryCompleted(context.read<UserCubit>().state.code!);
          },
          child: state.orders.isEmpty
              ? WorkerEmptyOrder(
                  title: "Không có đơn đã hoàn thành",
                  desc: "Không có đơn đã hoàn thành, vui lòng quay lại.")
              : ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return CardHistoryOrder(order: state.orders[index]);
                  },
                ),
        );
      }

      if (state is GetHistoryOrderCompletedError) {
        return Align(
            alignment: FractionalOffset.topCenter, child: Text(state.message));
      } else {
        return Container();
      }
    }));
  }
}
