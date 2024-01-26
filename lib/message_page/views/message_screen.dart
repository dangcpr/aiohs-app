import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/chat/models/chat.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/message_page/widgets/card_chat_info.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late ChatInfo chatInfo;
  String error = "";
  int loading = 0;
  bool showLoading = true;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      chatInfoFuncNotLoad();
    });
    super.initState();
    chatInfoFunc();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading == 1
        ? Center(
            child: CircularProgressIndicator(color: colorProject.primaryColor))
        : (loading == 2
            ? Text(error)
            : RefreshIndicator(
                color: colorProject.primaryColor,
                onRefresh: () async {
                  chatInfoFunc();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardChatInfo(chatInfo: chatInfo),
                    ],
                  ),
                )));
  }

  void chatInfoFunc() {
    setState(() {
      loading = 1;
    });
    try {
      ChatController().getChatInfo(context.read<UserCubit>().state.code!).then(
            (value) => setState(() {
              loading = 0;
              chatInfo = value;
            }),
          );
    } catch (e) {
      setState(() {
        loading = 2;
        error = e.toString();
      });
    }
  }

  void chatInfoFuncNotLoad() {
    try {
      ChatController().getChatInfo(context.read<UserCubit>().state.code!).then(
            (value) => setState(() {
              chatInfo = value;
            }),
          );
    } catch (e) {
      setState(() {
        loading = 2;
        error = e.toString();
      });
    }
  }
}
