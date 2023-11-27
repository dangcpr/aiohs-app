import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_cubit.dart';
import 'package:rmservice/history/cubits/get_history_order.dart/get_history_order_state.dart';
import 'package:rmservice/history/widgets/card_order.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class HistoryOrderComming extends StatefulWidget {
  const HistoryOrderComming({super.key});

  @override
  State<HistoryOrderComming> createState() => _HistoryOrderCommingState();
}

class _HistoryOrderCommingState extends State<HistoryOrderComming> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetHistoryOrderCubit>();
    cubit.getHistory(context.read<UserCubit>().state.code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<GetHistoryOrderCubit, GetHistoryOrderState>(
            builder: (context, state) {
      if (state is GetHistoryOrderLoading) {
        return const Center(
          child: CircularProgressIndicator(color: colorProject.primaryColor),
        );
      }

      if (state is GetHistoryOrderLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            await context
                .read<GetHistoryOrderCubit>()
                .getHistory(context.read<UserCubit>().state.code!);
          },
          child: ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              return CardHistoryOrder(order: state.orders[index]);
            },
          ),
        );
      }

      if (state is GetHistoryOrderError) {
        return Text(
          state.message,
        );
      } else {
        return Container();
      }
    }));
  }
}
