import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/post_job/cubits/get_post_all/get_post_all_cubit.dart';

import '../../login/cubit/user_cubit.dart';
import '../../shopping/widgets/dialog_wrong.dart';
import '../../shopping/widgets/text_label.dart';
import '../../utilities/components/button_green.dart';
import '../../utilities/components/empty_card.dart';
import '../../utilities/components/text_field_basic.dart';
import '../../utilities/components/text_sub_label.dart';
import '../../utilities/constants/variable.dart';
import '../widgets/card_post.dart';
import '../widgets/card_posted.dart';

class JobPost extends StatefulWidget {
  const JobPost({super.key});

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
  double distance = 5;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<GetPostAllCubit>().reset();
    context
        .read<GetPostAllCubit>()
        .getPostAll(distance, context.read<UserCubit>().state.code!);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context
            .read<GetPostAllCubit>()
            .getPostAll(distance, context.read<UserCubit>().state.code!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    var getAllPost = context.watch<GetPostAllCubit>();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextSubLabel(
                label: "Bạn muốn tìm việc trong khoảng: ",
                isDarkMode: isDarkMode,
              ),
              Text(
                distance.toString() + " km",
                style: TextStyle(
                  fontFamily: fontBoldApp,
                  fontSize: fontSize.medium,
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                child: Icon(
                  Icons.filter_list,
                  color: colorProject.primaryColor,
                  size: 30,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: changeDistance(isDarkMode),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: getAllPost is GetPostAllFailed
                ? Center(child: Text("Đã có lỗi xảy ra"))
                : (getAllPost.posts.isEmpty &&
                        getAllPost.state is GetPostAllSuccess)
                    ? WorkerEmptyOrder(
                        title: "Không có bài post",
                        desc:
                            "Hiện không có bài post nào, vui lòng thử lại sau.",
                      )
                    : SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            for (int i = 0; i < getAllPost.posts.length; i++)
                              CardPost(post: getAllPost.posts[i]),
                            //loading
                            BlocBuilder<GetPostAllCubit, GetPostAllState>(
                                builder: (context, state) {
                              if (state is GetPostAllLoading) {
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
        ],
      ),
    );
  }

  Widget changeDistance(bool isDarkMode) {
    TextEditingController controller = TextEditingController();
    controller.text = distance.toString();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextLabel(label: "Thay đổi khoảng cách", isDarkMode: isDarkMode),
          SizedBox(height: 20),
          TextFieldBasic(
            controller: controller,
            isDarkMode: isDarkMode,
            hintText: "Khoảng cách (km)",
          ),
          SizedBox(height: 20),
          ButtonGreenApp(
            label: "Đồng ý",
            onPressed: () {
              if (double.tryParse(controller.text) == null ||
                  double.tryParse(controller.text)! <= 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(
                      notification: "Khoảng cách phải là số và lớn hơn không",
                    );
                  },
                );
              } else {
                setState(() {
                  distance = double.tryParse(controller.text)!;
                });
                Navigator.pop(context);
                context.read<GetPostAllCubit>().reset();
                context.read<GetPostAllCubit>().getPostAll(
                    distance, context.read<UserCubit>().state.code!);
              }
            },
          )
        ],
      ),
    );
  }
}
