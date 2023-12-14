import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/post_job/cubits/get_history_post_cubit/get_history_post_cubit.dart';

import '../../login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../widgets/card_posted.dart';

class JobPosted extends StatefulWidget {
  const JobPosted({super.key});

  @override
  State<JobPosted> createState() => _JobPostedState();
}

class _JobPostedState extends State<JobPosted> {
  @override
  void initState() {
    super.initState();
    context.read<GetHistoryPostCubit>().setInitial();
    context.read<GetHistoryPostCubit>().getHistory(
        context.read<UserCubit>().state.code!, 'JOB_POSTING_STATUS_ACTIVE');
  }

  @override
  Widget build(BuildContext context) {
    var getHistory = context.watch<GetHistoryPostCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        getHistory.setInitial();
        getHistory.getHistory(
            context.read<UserCubit>().state.code!, 'JOB_POSTING_STATUS_ACTIVE');
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          child: getHistory is GetHistoryPostFailed
              ? Center(child: Text("Đã có lỗi xảy ra"))
              : Column(
                  children: [
                    for (int i = 0; i < getHistory.posts.length; i++)
                      CardHistoryPost(post: getHistory.posts[i]),
                    //loading
                    BlocBuilder<GetHistoryPostCubit, GetHistoryPostState>(
                        builder: (context, state) {
                      if (state is GetHistoryPostLoading) {
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
