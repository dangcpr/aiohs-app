import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/cubit/user_cubit.dart';
import '../cubits/get_history_post_cubit/get_history_post_cubit.dart';
import '../widgets/card_posted.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class JobClosed extends StatefulWidget {
  const JobClosed({super.key});

  @override
  State<JobClosed> createState() => _JobClosedState();
}

class _JobClosedState extends State<JobClosed> {
  @override
  void initState() {
    super.initState();
    context.read<GetHistoryPostCubit>().setInitial();
    context.read<GetHistoryPostCubit>().getHistory(
        context.read<UserCubit>().state.code!, 'JOB_POSTING_STATUS_INACTIVE');
  }

  @override
  Widget build(BuildContext context) {
    var getHistory = context.watch<GetHistoryPostCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        getHistory.setInitial();
        getHistory.getHistory(context.read<UserCubit>().state.code!,
            'JOB_POSTING_STATUS_INACTIVE');
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
