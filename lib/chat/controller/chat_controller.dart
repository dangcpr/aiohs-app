import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatController {
  Future<String> getChatToken(
      {required String requesterCode,
      required String receiverCode,
      required String title,
      required String postCode}) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.206.129:8080',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
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
}
