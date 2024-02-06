import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/laundry/models/info_laundry.dart';
import 'package:rmservice/laundry/models/price_laundry.dart';
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

class LaundryController {
  Future<PriceLaundry> getLaundryPrice() async {
    try {
      final response = await dio.get('/user/products/LAUNDRY');
      await Future.delayed(const Duration(milliseconds: 800));

      if (response.data['code'] == 0) {
        PriceLaundry priceLaundry =
            PriceLaundry.fromJson(response.data['price']);
        return priceLaundry;
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

  Future<String> orderLaundry(
      InfoLaundry infoLaundry, Address address, String userCode) async {
    try {
      final response =
          await dio.post('/user/$userCode/orders/laundry/create', data: {
        "order_amount": infoLaundry.totalPrice,
        "payment_method": infoLaundry.paymentMethod == "PAYMENT_METHOD_ZALOPAY"
            ? "PAYMENT_METHOD_WALLET"
            : infoLaundry.paymentMethod,
        "working_date":
            '${infoLaundry.sendDate!.year.toString().padLeft(4, '0')}-${infoLaundry.sendDate!.month.toString().padLeft(2, '0')}-${infoLaundry.sendDate!.day.toString().padLeft(2, '0')}',
        "working_hour":
            '${infoLaundry.sendTime!.hour.toString().padLeft(2, '0')}:${infoLaundry.sendTime!.minute.toString().padLeft(2, '0')}:00',
        "working_address": '${address.shortAddress!}-${address.address}',
        "latitude": address.latitude,
        "longitude": address.longitude,
        "note": infoLaundry.note,
        "agent_name": address.name,
        "agent_phone": address.phone,
        "city": address.city,
        "district": address.district,
        "ward": address.ward,
        "normal_clothes": {
          "clothes": infoLaundry.clothes,
          "blanket": infoLaundry.blanket,
          "mosquito": infoLaundry.mosquito,
          "net": infoLaundry.net,
          "drap": infoLaundry.drap,
          "topper": infoLaundry.topper,
          "pillow": infoLaundry.pillow
        },
        "others_clothes": {
          "comple": infoLaundry.blanket,
          "vietnam_dress": infoLaundry.vietnamDress,
          "wedding_dress": infoLaundry.weedingDress,
          "bleaching": infoLaundry.bleaching
        },
        "received_date":
            '${infoLaundry.sendDate!.year.toString().padLeft(4, '0')}-${infoLaundry.sendDate!.month.toString().padLeft(2, '0')}-${infoLaundry.sendDate!.day.toString().padLeft(2, '0')}',
        "price_type": infoLaundry.price_type,
      });
      await Future.delayed(const Duration(seconds: 1));
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

  Future<int> calculateLaundry(InfoLaundry infoLaundry) async {
    try {
      final response =
          await dio.post('/user/orders/laundry/prices/calculate', data: {
        "working_date":
            '${infoLaundry.sendDate!.year.toString().padLeft(4, '0')}-${infoLaundry.sendDate!.month.toString().padLeft(2, '0')}-${infoLaundry.sendDate!.day.toString().padLeft(2, '0')}',
        "working_hour":
            '${infoLaundry.sendTime!.hour.toString().padLeft(2, '0')}:${infoLaundry.sendTime!.minute.toString().padLeft(2, '0')}:00',
        "normal_clothes": {
          "clothes": infoLaundry.clothes,
          "blanket": infoLaundry.blanket,
          "mosquito": infoLaundry.mosquito,
          "net": infoLaundry.net,
          "drap": infoLaundry.drap,
          "topper": infoLaundry.topper,
          "pillow": infoLaundry.pillow,
        },
        "others_clothes": {
          "comple": infoLaundry.comple,
          "vietnam_dress": infoLaundry.vietnamDress,
          "wedding_dress": infoLaundry.weedingDress,
          "bleaching": infoLaundry.bleaching,
        },
        "price_type": infoLaundry.price_type,
      });
      await Future.delayed(const Duration(milliseconds: 500));
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
