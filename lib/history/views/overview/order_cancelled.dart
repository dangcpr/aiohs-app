import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/cubits/get_history_cancel/get_history_cancel_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/components/empty_card.dart';

import '../../../login/cubit/user_cubit.dart';
import '../../widgets/card_cancel.dart';
import '../../widgets/card_order.dart';

class HistoryOrderCancelled extends StatefulWidget {
  const HistoryOrderCancelled({super.key});

  @override
  State<HistoryOrderCancelled> createState() => _HistoryOrderCancelledState();
}

class _HistoryOrderCancelledState extends State<HistoryOrderCancelled> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetHistoryCancelCubit>();
    cubit.setInitial();
    cubit.getHistoryCancel(context.read<UserCubit>().state.code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<GetHistoryCancelCubit, GetHistoryCancelState>(
            builder: (context, state) {
      if (state is GetHistoryCancelLoading) {
        return const Center(
          child: CircularProgressIndicator(color: colorProject.primaryColor),
        );
      }

      if (state is GetHistoryCancelSuccess) {
        return RefreshIndicator(
          onRefresh: () async {
            await context
                .read<GetHistoryCancelCubit>()
                .getHistoryCancel(context.read<UserCubit>().state.code!);
          },
          child: state.orders.isEmpty ? WorkerEmptyOrder(
                title: "Không có đơn đã hoàn thành",
                desc: "Không có đơn đã hoàn thành, vui lòng quay lại."
              ) : ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              return CardHistoryOrderCancel(order: state.orders[index]);
            },
          ),
        );
      }

      if (state is GetHistoryCancelFailed) {
        return Text(
          state.message,
        );
      } else {
        return Container();
      }
    }));
  }
}
