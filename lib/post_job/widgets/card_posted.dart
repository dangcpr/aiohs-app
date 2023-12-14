import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/history/helpers/get_detail.dart';
import 'package:rmservice/history/helpers/get_icon.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/post_job/models/history_job_posting.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import 'detail_post.dart';

class CardHistoryPost extends StatefulWidget {
  const CardHistoryPost({super.key, required this.post});

  final HistoryJobPosting post;

  @override
  State<CardHistoryPost> createState() => _CardHistoryPostState();
}

class _CardHistoryPostState extends State<CardHistoryPost> {
  NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');
  //state = 0: bình thường
  //state = 1: đang load
  //state = 2: đã load xong
  int state = 0;
  @override
  Widget build(BuildContext context) {
    var userCubit = context.read<UserCubit>();
    DateTime createDate =
        new DateFormat("yyyy-MM-dd HH:mm:ss").parse(widget.post.createdAt);
    String createDateString =
        new DateFormat("dd-MM-yyyy HH:mm:ss").format(createDate);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorProject.primaryColor),
        ),
        child: ListTile(
          onTap: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPost(
                  post: widget.post,
                ),
              ),
            );
          },
          leading: Icon(
            getIcon(widget.post.code),
            color: colorProject.primaryColor,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorProject.primaryColor,
          ),
          title: Text(
            widget.post.title,
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger,
              color: colorProject.primaryColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Tiền lương: ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Text(
                    '${numberFormat.format(widget.post.wageMin)} - ${numberFormat.format(widget.post.wageMax)}',
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ngày, giờ đặt: ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Text(
                    createDateString,
                    style: TextStyle(
                      fontFamily: fontApp,
                      fontSize: fontSize.medium,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'Tuổi: ',
                    style: TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${widget.post.candidateMinAge} - ${widget.post.candidateMaxAge}',
                      style: TextStyle(
                        fontFamily: fontApp,
                        fontSize: fontSize.medium,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
