import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rmservice/maid_near/models/maid_res.dart';
import 'package:rmservice/maid_near/views/maid_contact_tab.dart';
import 'package:rmservice/maid_near/views/maid_rating_tab.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MaidView extends StatefulWidget {
  const MaidView({super.key, required this.maidNear});

  final MaidRes maidNear;

  @override
  State<MaidView> createState() => _MaidViewState();
}

class _MaidViewState extends State<MaidView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          widget.maidNear.name,
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
            fontFamily: fontBoldApp,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: size.height * 1,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.maidNear.avatar_url == ''
                        ? CircleAvatar(
                            child: Image.asset('assets/images/avatar.png'))
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.maidNear.avatar_url),
                            radius: 40,
                          ),
                    Text(
                      textAlign: TextAlign.center,
                      widget.maidNear.name,
                      style: TextStyle(
                        fontFamily: fontBoldApp,
                        fontSize: fontSize.mediumLarger,
                        color: colorProject.primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          itemSize: 30,
                          initialRating: widget.maidNear.avg_star.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          onRatingUpdate: (rating) {
                            null;
                          },
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 255, 235, 59),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: TabBar(
                  indicatorColor: colorProject.primaryColor,
                  labelStyle: TextStyle(
                    color: colorProject.primaryColor,
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.medium,
                  ),
                  tabs: [
                    Tab(text: "Nhận xét"),
                    Tab(text: "Liên hệ"),
                    //if (widget.isUser == false) Tab(text: "Liên hệ"),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //Add this to give height
                  child: TabBarView(children: [
                    MaidRatingTab(maidNear: widget.maidNear),
                    MaidContactTab(maidNear: widget.maidNear),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
