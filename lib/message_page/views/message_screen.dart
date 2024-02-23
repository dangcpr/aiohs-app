import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/chat/models/chat.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/message_page/widgets/card_chat_info.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late List<ChatInfo> listChatInfo;
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
            ? Center(child: Text(error))
            : RefreshIndicator(
                color: colorProject.primaryColor,
                onRefresh: () async {
                  chatInfoFunc();
                },
                child: listChatInfo.isEmpty
                    ? WorkerEmptyOrder(
                        title: "Không có tin nhắn",
                        desc: "Hiện tại bạn chưa có tin nhắn")
                    : ListView.builder(
                        itemCount: listChatInfo.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CardChatInfo(
                            chatInfo: listChatInfo[index],
                          );
                        }),
              ));
  }

  void chatInfoFunc() async {
    setState(() {
      loading = 1;
    });
    try {
      List<ChatInfo> value = await ChatController()
          .getListChat(context.read<UserCubit>().state.code!);
      setState(() {
        listChatInfo = value;
        loading = 0;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        loading = 2;
        error = e.toString();
      });
    }
  }

  void chatInfoFuncNotLoad() {
    try {
      ChatController().getListChat(context.read<UserCubit>().state.code!).then(
            (value) => setState(() {
              listChatInfo = value;
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
