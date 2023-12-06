import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/air_conditioning_cleaning/model/air_conditioning_cleaning_price.dart';
import 'package:rmservice/air_conditioning_cleaning/model/info_air_conditioning_cleaning.dart';
import 'package:rmservice/cooking/model/cooking_price.dart';

import '../../cleaning_hourly/models/address.dart';
import '../../utilities/constants/variable.dart';
import '../cubit/save_info_air_conditioning_cleaning.dart';

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

class AirCondRepo {
  Future<AirCondPrice> getPriceAirCond() async {
    try {
      final response = await dio.get('/user/products/AIR_CONDITIONING_CLEAN');
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        AirCondPrice airCondPrice =
            AirCondPrice.fromJson(response.data['price']);
        print(response.data['price']);
        return airCondPrice;
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

  Future<void> orderAirCond(InfoAirConditioningCleaning info, Address address,
      String userCode) async {
    try {
      final response = await dio
          .post('/user/$userCode/orders/air-conditioning/create', data: {
        "order_amount": info.price,
        "payment_method": info.paymentMethod,
        "working_date":
            '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
        "working_hour":
            '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
        "working_address": '${address.shortAddress!}-${address.address!}',
        "note": info.note,
        "latitude": address.latitude,
        "longitude": address.longitude,
        "agent_name": address.name,
        "agent_phone": address.phone,
        "wall": {
          "number_bellow_2hp": info.details[0].amount,
          "number_above_2hp": info.details[1].amount,
          "gas_refill_bellow_2hp": info.details[0].hasGasAmount,
          "gas_refill_above_2hp": info.details[1].hasGasAmount
        },
        "portable": {
          "number_ac": info.details[2].amount,
          "gas_refill": info.details[2].hasGasAmount
        },
        "cassette": {
          "number_bellow_3hp": info.details[3].amount,
          "number_above_3hp": info.details[4].amount,
          "gas_refill_bellow_3hp": info.details[3].hasGasAmount,
          "gas_refill_above_3hp": info.details[4].hasGasAmount
        },
        "floor": {
          "number_bellow_5hp": info.details[5].amount,
          "number_above_5hp": info.details[6].amount,
          "gas_refill_bellow_5hp": info.details[5].hasGasAmount,
          "gas_refill_above_5hp": info.details[6].hasGasAmount
        },
        "built_in": {
          "number_ac": info.details[7].amount,
          "gas_refill": info.details[7].hasGasAmount
        }
      });
      print(
          "-------------------------------------------------------------------------------");
      print('data reponse: ${response.data}');
      print(
          "-------------------------------------------------------------------------------");
      if (response.data['code'] == 0) {
        return;
      } else {
        String message = jsonEncode(response.data['message']);
        throw message;
      }
    } on DioException catch (e) {
      debugPrint(e.type.toString());
      print(
          "-------------------------------------------------------------------------------");
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection Timeout';
      }

      if (e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        throw 'Internet Error or Server Error';
      }
      debugPrint(e.type.toString());
      print(
          "-------------------------------------------------------------------------------");
      throw 'Server Error';
    }
  }
}
