import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/post_job/views/job_activing.dart';
import 'package:rmservice/post_job/views/job_closed.dart';
import 'package:rmservice/post_job/views/job_posted.dart';
import 'package:rmservice/post_job/views/post_job_register.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  List<Tab> tabs = <Tab>[
    Tab(icon: Icon(Icons.all_inbox), text: "Bạn đã đăng"),
    Tab(icon: Icon(Icons.directions_transit), text: "Đang nhận"),
    Tab(icon: Icon(Icons.directions_bike), text: "Đã đóng"),
  ];
  List<Widget> pages = <Widget>[
    JobPosted(),
    JobActiving(),
    JobClosed(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Đăng tin giúp việc",
            style: TextStyle(
              fontSize: fontSize.mediumLarger,
              fontFamily: fontBoldApp,
            ),
          ),
          bottom: const TabBar(
            labelColor: colorProject.primaryColor,
            indicatorColor: colorProject.primaryColor,
            tabs: [
              Tab(icon: Icon(Icons.all_inbox), text: "Bạn đã đăng"),
              Tab(icon: Icon(Icons.access_time), text: "Đang nhận"),
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
            Navigator.push(
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
