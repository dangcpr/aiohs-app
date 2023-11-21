import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

class GetProductController {
  Future<String> getProducts() async {
    try {
      final response = await dio.get('/user/products');
      await Future.delayed(const Duration(seconds: 1));
      if (response.data['code'] == 0) {
        String data = jsonEncode(response.data['products']);
        return data;
      }
      else {
        String message = jsonEncode(response.data['message']);
        throw message;
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
