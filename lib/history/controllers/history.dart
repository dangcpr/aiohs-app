import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/models/order_result.dart';

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

class HistoryController {
  Future<OrderResult> getOrders(String userCode, String status, int next) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders',
        queryParameters: {'limit': 7, 'next': next, 'status': status},
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        List<Order> orders = [];
        orders = (response.data['orders'] as List)
            .map((e) => Order.fromJson(e))
            .toList();

        debugPrint(orders.length.toString());

        print(
            "-------------------------------------------------------------------------------");
        print('data reponse: ${response.data}');
        print(
            "-------------------------------------------------------------------------------");

        return OrderResult(orders, int.tryParse(response.data['next'])!);
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

  Future<CleaningHourlyHistory> getCleaningHourlyHistory(
      String userCode, String orderCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/$orderCode',
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        CleaningHourlyHistory history =
            CleaningHourlyHistory.fromJson(response.data);
        return history;
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

  Future<LaundryHistory> getLaundryHistory(
      String userCode, String orderCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/$orderCode',
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        LaundryHistory history = LaundryHistory.fromJson(response.data);
        return history;
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

  Future<ShoppingHistory> getShoppingHistory(
      String userCode, String orderCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/$orderCode',
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        debugPrint(jsonEncode(response.data));
        ShoppingHistory history = ShoppingHistory.fromJson(response.data);
        return history;
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
