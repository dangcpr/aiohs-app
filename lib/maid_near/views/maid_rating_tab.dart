import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/maid_near/cubits/get_maid_ratings/get_maid_ratings_cubit.dart';
import 'package:rmservice/maid_near/cubits/get_maid_ratings/get_maid_ratings_state.dart';
import 'package:rmservice/maid_near/models/maid_res.dart';
import 'package:rmservice/maid_near/widgets/maid_rating_card.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MaidRatingTab extends StatefulWidget {
  const MaidRatingTab({super.key, required this.maidNear});

  final MaidRes maidNear;

  @override
  State<MaidRatingTab> createState() => _MaidRatingTabState();
}

class _MaidRatingTabState extends State<MaidRatingTab> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    var userCubit = context.read<UserCubit>();
    context.read<GetMaidRatingsCubit>().initState();
    context.read<GetMaidRatingsCubit>().getMaidRatings(
        userCubit.state.full_name == ''
            ? userCubit.state.email
            : userCubit.state.full_name,
        widget.maidNear.code,
        10);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context.read<GetMaidRatingsCubit>().getMaidRatings(
            userCubit.state.full_name == ''
                ? userCubit.state.email
                : userCubit.state.full_name,
            widget.maidNear.code,
            10);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userCubit = context.watch<UserCubit>();
    var getMaidRatingsCubit = context.watch<GetMaidRatingsCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GetMaidRatingsCubit>().initState();
        context.read<GetMaidRatingsCubit>().getMaidRatings(
            userCubit.state.full_name == ''
                ? userCubit.state.email
                : userCubit.state.full_name,
            widget.maidNear.code,
            10);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < getMaidRatingsCubit.listRatingRes.length; i++)
                MaidRatingCard(
                  maidRating: getMaidRatingsCubit.listRatingRes[i],
                ),
              if (getMaidRatingsCubit.state is GetMaidRatingsLoading)
                const Center(child: CircularProgressIndicator(color: colorProject.primaryColor)),
              if (getMaidRatingsCubit.state is GetMaidRatingsError)
                Text((getMaidRatingsCubit.state as GetMaidRatingsError).message),       
            ]
          ),
        ),
      ),
    );
  }
}
