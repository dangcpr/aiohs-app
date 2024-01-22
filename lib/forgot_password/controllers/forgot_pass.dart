import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/handle_error.dart';
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

class ForgotPassController {
  Future<String> forgotPassOTP(String email) async {
    try {
      var response = await dio.post(
        '/user/info/password-forgot',
        data: {
          'email': email,
        },
      );
      debugPrint("user_code: ${response.data}");

      if (response.data['code'] == 0) {
        return response.data['user_code'];
      } else {
        throw response.data['message'];
      }
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> forgotPassSet({
    required String userCode,
    required String otp,
    required String password,
  }) async {
    try {
      var response = await dio.post(
        '/user/info/password-set',
        data: {
          'user_code': userCode,
          'otp_code': otp,
          'new_password': password,
        },
      );
      debugPrint("data: ${response.data}");
      if (response.data['code'] == 0) {
        return;
      } else {
        throw response.data['message'];
      }
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }
}
