import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/post_job/views/job_closed.dart';
import 'package:rmservice/post_job/views/job_posted.dart';
import 'package:rmservice/post_job/views/post_job_register.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import 'job_posts.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  List<Widget> pages = <Widget>[
    JobPost(),
    JobPosted(),
    JobClosed(),
  ];

  @override
  Widget build(BuildContext context) {
    var role = context.read<UserCubit>().state.role;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tin giúp việc",
            style: TextStyle(
              fontSize: fontSize.mediumLarger,
              fontFamily: fontBoldApp,
            ),
          ),
          bottom: TabBar(
            labelColor: colorProject.primaryColor,
            indicatorColor: colorProject.primaryColor,
            tabs: [
              Tab(icon: Icon(Icons.note_alt), text: "Posts"),
              Tab(icon: Icon(Icons.all_inbox), text: "Bạn đã đăng"),
              Tab(icon: Icon(Icons.close), text: "Đã đóng"),
            ],
          ),
        ),
        body: TabBarView(
          children: pages,
          physics: BouncingScrollPhysics(),
        ),
        floatingActionButton: TextButton(
          child: Text(
            "Đăng tin giúp việc",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize.medium,
              fontFamily: fontBoldApp,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Color(0xFF00B27D),
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: PostJobRegister(),
              ),
            );
          },
        ),
      ),
    );
  }
}
