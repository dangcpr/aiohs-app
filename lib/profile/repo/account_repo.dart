import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/login/models/user.dart';

import '../../utilities/constants/variable.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: debugServer,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
  ),
);

class AccountRepo {
  Future<User> updateProfile(
      String userCode, String fullName, String phone, String email) async {
    try {
      final response = await dio.post(
        '/user/${userCode}/profile/update',
        data: {
          "full_name": fullName,
          "email": email,
          "phone_number": phone,
          "avatar_url": " "
        },
      );
      if (response.data['code'] == 0) {
        print('test repo update: ${response.data['user']}');
        return User.fromJson(response.data['user']);
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
