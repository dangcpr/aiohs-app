import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/laundry/models/info_laundry.dart';
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

class LaudryController {
  Future<void> orderLaundry(InfoLaundry infoLaundry, Address address, String userCode) async {
    try {
      final response =
          await dio.post('/user/$userCode/orders/laundry/create', data: {
        "order_amount": infoLaundry.totalPrice,
        "payment_method": infoLaundry.paymentMethod,
        "working_date": '${infoLaundry.sendDate!.year}-${infoLaundry.sendDate!.month}-${infoLaundry.sendDate!.day}',
        "working_hour": '${infoLaundry.sendTime!.hour.toString().padLeft(2, '0')}:${infoLaundry.sendTime!.minute.toString().padLeft(2, '0')}:00',
        "working_address": '${address.shortAddress!}-${address.address}',
        "note": infoLaundry.note,
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
        }
      });
      await Future.delayed(const Duration(seconds: 1));
      if (response.data['code'] == 0) {
        return;
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
