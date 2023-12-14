import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/variable.dart';
import '../models/order.dart';

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

class HistoryCancelled {
  Future<List<Order>> getOrdersCancelled(String userCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders',
        queryParameters: {
          'limit': 100,
          'next': 0,
          'status': 'ORDER_STATUS_CANCELED',
          'search_role_type': 'renter',
        },
      );
      //await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        List<Order> orders = [];
        orders = (response.data['orders'] as List)
            .map((e) => Order.fromJson(e))
            .toList();
        return orders;
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

  Future<void> ordersCancelled(String userCode, String orderCode) async {
    try {
      final response =
          await dio.get('/user/$userCode/orders/$orderCode/cancel');

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
