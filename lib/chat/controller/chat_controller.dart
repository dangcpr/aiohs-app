import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/chat/models/chat.dart';
import 'package:rmservice/chat/models/chat_detail.dart';
import 'package:rmservice/utilities/constants/handle_error.dart';
import 'package:rmservice/utilities/constants/variable.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://' + serverChat,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
  ),
);

class ChatController {
  Future<String> getChatToken(
      {required String requesterCode,
      required String receiverCode,
      required String title,
      required String postCode}) async {
    try {
      final response = await dio.post('/ws/info/parsing', data: {
        "post_code":
            postCode, //user clicks the chat button of the area-booking or job-posting post, you need to get the code and name of the post
        "post_name": title,
        "requester": requesterCode, //user_code who clicks the chat button,
        "receiver": receiverCode //user_code who chats with
      });
      await Future.delayed(const Duration(seconds: 1));
      if (response.statusCode == 200) {
        return response.data['result'];
      } else {
        String message = jsonEncode(response.data['message']);
        throw message;
      }
    } on DioException catch (e) {
      debugPrint(e.type.toString());
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      }

      if (e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        throw 'Internet Error or Server Error';
      }
      debugPrint(e.type.toString());
      throw 'Server Error';
    }
  }

  Future<ChatInfo> getChatInfo(String userCode) async {
    try {
      final response = await dio.get('/ws/chat/rooms', queryParameters: {
        "userCode": userCode,
      });
      await Future.delayed(const Duration(milliseconds: 400));
      debugPrint("get chat info");

      //if (response.statusCode == 200) {
      return ChatInfo(
        room_id: response.data['room_id'],
        post_code: response.data['post_code'],
        post_name: response.data['post_name'],
        requester: response.data['requester'],
        receiver: response.data['receiver'],
      );
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ChatDetailResult> getChatDetail(String room_id, String next) async {
    try {
      final response = await dio.get('/ws/chat/history', queryParameters: {
        "roomId": room_id,
        "next": next,
        "limit": 10,
      });
      debugPrint("get chat detail");
      await Future.delayed(const Duration(seconds: 1));
      //if (response.statusCode == 200) {
      List<ChatDetail> chatDetailList = [];
      for (var item in response.data['result']) {
        chatDetailList.add(ChatDetail.fromJson(item));
      }
      return ChatDetailResult(
        next: response.data['next'],
        result: chatDetailList,
      );
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }
}
