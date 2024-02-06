import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/cleaning_longterm/model/info_cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/model/price_cleaning_longterm.dart';
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

class CleaningLongTermRepo {
  Future<CleaningLongTermPrice> getPriceCleaningLongTerm() async {
    try {
      final response = await dio.get('/user/products/CLEAN_SUBSCRIPTION');
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        CleaningLongTermPrice cleaningLongTermPrice =
            CleaningLongTermPrice.fromJson(response.data['price']);
        return cleaningLongTermPrice;
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

  Future<void> orderCleaningLongTerm(
      InfoCleaningLongTerm info, Address address, String userCode) async {
    List<String> listDay = [];
    for (int i = 0; i < info.days.length; i++) {
      listDay.add(info.days[i].toString());
    }
    try {
      final response = await dio.post(
        '/user/$userCode/orders/clean-subscription/create',
        data: {
          "order_amount": info.price,
          "payment_method": info.paymentMethod,
          "working_hour":
              '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
          "working_address": '${address.shortAddress!}-${address.address!}',
          "agent_name": address.name,
          "agent_phone": address.phone,
          "note": info.note,
          "latitude": address.latitude,
          "longitude": address.longitude,
          "city": address.city,
          "district": address.district,
          "ward": address.ward,
          "working_dates": listDay,
          "duration_per_day": info.duration,
          "number_of_month": info.month,
        },
      );
      if (response.data['code'] == 0) {
        return;
      } else {
        String message = jsonEncode(response.data['message']);
        throw message;
      }
    } on DioException catch (e) {
      debugPrint('${e.type.toString()} + 123');
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

  Future<int> caculatePrice(InfoCleaningLongTerm info) async {
    try {
      List<String> listDay = [];
      for (int i = 0; i < info.days.length; i++) {
        listDay.add(info.days[i].toString());
      }
      print('test: ${info.toJson().toString()}');
      final response = await dio.post(
        '/user/orders/clean-subscription/prices/calculate',
        data: {
          "working_hour":
              '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
          "working_dates": listDay,
          "duration_per_day": info.duration,
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
        // throw 'Internet Error or Server Error';
        throw e.toString();
      }
      debugPrint(e.type.toString());
      throw e.toString();
    }
  }
}
