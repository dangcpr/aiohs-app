import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/history/models/cleaning_hourly_history.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/history/models/order.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../models/air_conditioning_history.dart';
import '../models/cleaning_longterm_history.dart';
import '../models/cooking_history.dart';

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
  Future<List<Order>> getOrders(String userCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders',
        queryParameters: {'limit': 100, 'next': 0},
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

  Future<CleaningLongTermHistory> getCleaningLongTermHistory(
      String userCode, String orderCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/$orderCode',
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        CleaningLongTermHistory history =
            CleaningLongTermHistory.fromJson(response.data);
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

  Future<CleaningAirCondHistory> getCleaningAirCondHistory(
      String userCode, String orderCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/$orderCode',
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        CleaningAirCondHistory history =
            CleaningAirCondHistory.fromJson(response.data);
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

  Future<CookingHistory> getCookingHistory(
      String userCode, String orderCode) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/$orderCode',
      );
      await Future.delayed(const Duration(milliseconds: 700));

      if (response.data['code'] == 0) {
        CookingHistory history = CookingHistory.fromJson(response.data);
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
