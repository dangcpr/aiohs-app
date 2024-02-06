import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/cleaning_hourly/models/cleaning_hourly_price.dart';
import 'package:rmservice/cleaning_hourly/models/info_cleaning_hourly.dart';
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

class CleaningHourlyController {
  Future<CleaningHourlyPrice> getPriceCleaningHourly() async {
    try {
      final response = await dio.get('/user/products/CLEAN_ON_DEMAND');
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        CleaningHourlyPrice cleaningHourlyPrice =
            CleaningHourlyPrice.fromJson(response.data['price']);
        return cleaningHourlyPrice;
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

  Future<String> orderCleaningHourly(
      InfoCleaningHourly info, Address address, String userCode) async {
    try {
      final response = await dio.post(
        '/user/$userCode/orders/clean-demand/create',
        data: {
          "order_amount": info.price,
          "payment_method": info.paymentMethod == "PAYMENT_METHOD_ZALOPAY"
              ? "PAYMENT_METHOD_WALLET"
              : info.paymentMethod,
          "working_date":
              '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
          "working_hour":
              '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
          "working_address": '${address.shortAddress!}-${address.address!}',
          "agent_name": address.name,
          "agent_phone": address.phone,
          "latitude": address.latitude,
          "longitude": address.longitude,
          "duration": info.realDuration,
          "house_with_pet": info.hasPet,
          "with_home_cooking": info.cooking,
          "with_laundry": info.iron,
          "bring_tools": info.bringTool,
          "note": info.note,
          "city": address.city,
          "district": address.district,
          "ward": address.ward,
        },
      );
      if (response.data['code'] == 0) {
        return response.data['order_code'];
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

  Future<int> caculatePrice(InfoCleaningHourly info) async {
    try {
      final response = await dio.post(
        '/user/orders/clean-demand/prices/calculate',
        data: {
          "working_date":
              '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
          "working_hour":
              '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
          "duration": info.realDuration,
          "with_home_cooking": info.cooking,
          "with_laundry": info.iron,
          "bring_tools": info.bringTool,
        },
      );

      await Future.delayed(const Duration(milliseconds: 800));

      if (response.statusCode == 200) {
        int price = response.data['price'];
        debugPrint(price.toString());
        return price;
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
