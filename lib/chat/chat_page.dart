import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String chatToken;
  late WebSocketChannel channel = IOWebSocketChannel.connect(
      Uri.parse('ws://192.168.206.129:8080/ws/chat/start?key=$chatToken'));

  ChatPage({super.key, required this.chatToken});

  @override
  _ChatPageState createState() => _ChatPageState(channel: channel);
}

class _ChatPageState extends State<ChatPage> {
  final WebSocketChannel? channel;
  List<types.Message> _messages = [];
  final _user2 = const types.User(
    id: '2',
  );
  final _user = types.User(
    id: '1',
  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  _ChatPageState({this.channel}) {
    // if (channel == null) {
    //   print("Channel is null");
    // } else {
    //   print("Channel is not null");
    // }
    channel!.stream.listen((data) {
      var content = jsonDecode(data);
      setState(() {
        var textMessage;
        content['user_code'] != context.read<UserCubit>().state.code
            ? textMessage = types.TextMessage(
                author: _user2,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                id: const Uuid().v4(),
                text: content['content'],
              )
            : null;
        _addMessage(textMessage);
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    channel!.sink.add(message.text);
    _addMessage(textMessage);
    print(_messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
          theme: DefaultChatTheme(
            inputBackgroundColor: colorProject.primaryColor,
            inputTextColor: Colors.white,
            messageInsetsVertical: 10, // padding của tin nhắn
            messageInsetsHorizontal: 12,
            primaryColor: colorProject.primaryColor,
            secondaryColor: Colors.grey.shade200,
            inputPadding: const EdgeInsets.all(12),
            inputBorderRadius: const BorderRadius.all(Radius.circular(30)),
            inputTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: fontApp,
              fontSize: 16,
            ),
            receivedMessageBodyTextStyle: const TextStyle(
              color: Colors.black,
              fontFamily: fontApp,
              fontSize: 16,
            ),
            sentMessageBodyTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: fontApp,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }
}
