import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/sign_up/models/user.dart';
import 'package:rmservice/utilities/constants/variable.dart';

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

class SignupController {
  Future<void> signup(UserSignup user) async {
    try {
      //delay 3s
      final response = await dio.post(
        '/user/register',
        data: {
          "email": user.email,
          // "phone": user.phone,
          "password": user.password,
        },
      );

      if (response.data['code'] == 0) debugPrint("Thành công");
      else {
        throw response.data['message'];
      }
    } on DioException catch (e) {
      debugPrint(e.type.toString());
      if(e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      }

      if(e.type == DioExceptionType.unknown || e.type == DioExceptionType.connectionError) {
        throw 'Internet Error or Server Error';
      }
      debugPrint(e.type.toString());
      throw 'Server Error';
    }
  }
}
