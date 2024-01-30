// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/chat/chat_page.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/chat/models/chat.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../chat/chat_page_v2.dart';

class CardChatInfo extends StatelessWidget {
  const CardChatInfo({super.key, required this.chatInfo});

  final ChatInfo chatInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: Image.asset('assets/images/no_avatar.png').image,
        ),
        title: Text(
          chatInfo.postName,
          style: TextStyle(fontFamily: fontBoldApp),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check),
                Expanded(
                  child: Text(
                    chatInfo.lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.75,
            )
          ],
        ),
        //trailing: Text(chatInfo.lastMessageTime!),
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) => Center(
              child:
                  CircularProgressIndicator(color: colorProject.primaryColor),
            ),
          );
          Navigator.pop(context);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ChatPageV2(
                    chatToken: chatInfo.key,
                    roomId: chatInfo.roomId,
                    postName: chatInfo.postName,
                  )));
        },
      ),
    );
  }
}
