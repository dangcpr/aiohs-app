// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/chat/chat_page.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/chat/models/chat.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';

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
          chatInfo.post_name,
          style: TextStyle(fontFamily: fontBoldApp),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Người gửi: " +
                  (chatInfo.requester == context.read<UserCubit>().state.code
                      ? "Bạn"
                      : chatInfo.requester),
            ),
            Text(
              "Người nhận: " +
                  (chatInfo.receiver == context.read<UserCubit>().state.code
                      ? "Bạn"
                      : chatInfo.receiver),
            ),
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
          String token = await ChatController().getChatToken(
              requesterCode: chatInfo.requester,
              receiverCode: chatInfo.receiver,
              title: chatInfo.post_name,
              postCode: chatInfo.post_code);
          Navigator.pop(context);
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: ChatPage(
                    chatToken: token,
                  )));
        },
      ),
    );
  }
}
