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

class CompletedAndReviewOrder {
  Future<void> completedOrder(String userCode, String orderCode) async {
    try {
      final response =
          await dio.get('/user/$userCode/orders/$orderCode/complete');
      await Future.delayed(const Duration(milliseconds: 500));
      if (response.data["code"] == 0) {
        return;
      } else {
        throw response.data['message'];
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

  Future<void> reviewOrder(
      String userCode, String orderCode, String comment, double star) async {
    try {
      final response =
          await dio.post('/user/$userCode/orders/$orderCode/reviews', data: {
        "comment": comment,
        "star": star,
      });
      await Future.delayed(const Duration(milliseconds: 500));
      if (response.data["code"] == 0) {
        return;
      } else {
        throw response.data['message'];
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
