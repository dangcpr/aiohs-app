import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/cooking/model/cooking_price.dart';
import 'package:rmservice/cooking/model/info_cooking.dart';

import '../../cleaning_hourly/models/address.dart';
import '../../utilities/constants/variable.dart';

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

class CookingRepo {
  Future<CookingPrice> getPriceCooking() async {
    try {
      final response = await dio.get('/user/products/HOME_COOKING');
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        CookingPrice cookingPrice =
            CookingPrice.fromJson(response.data['price']);
        print(response.data['price']);
        return cookingPrice;
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

  Future<String> orderCooking(
      InfoCooking info, Address address, String userCode) async {
    try {
      final response = await dio.post(
        '/user/$userCode/orders/home-cooking/create',
        data: {
          "order_amount": info.price,
          "payment_method": info.paymentMethod == "PAYMENT_METHOD_ZALOPAY"
              ? "PAYMENT_METHOD_WALLET"
              : info.paymentMethod,
          "working_hour":
              '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
          "working_address": '${address.shortAddress!}-${address.address!}',
          "note": info.note,
          "agent_name": address.name,
          "agent_phone": address.phone,
          "working_date":
              '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
          "latitude": address.latitude,
          "longitude": address.longitude,
          "city": address.city,
          "district": address.district,
          "ward": address.ward,
          "number_of_people": info.numberOfPeople,
          "courses": [info.food1, info.food2, info.food3, info.food4],
          "with_grocery_assistant": true,
          "grocery_assistant_amount": 0
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

  Future<int> caculatePrice(InfoCooking info) async {
    try {
      print('test: ${info.toJson().toString()}');
      List<String> foods = [];
      if (info.food1 != '') {
        foods.add(info.food1);
      }
      if (info.food2 != '') {
        foods.add(info.food2);
      }
      if (info.food3 != '') {
        foods.add(info.food3);
      }
      if (info.food4 != '') {
        foods.add(info.food4);
      }
      print('foods: ${foods.length}');
      final response = await dio.post(
        '/user/orders/home-cooking/prices/calculate',
        data: {
          "working_hour":
              '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
          "working_date":
              '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
          "number_of_people": info.numberOfPeople,
          "courses": foods,
          "with_grocery_assistant": info.chooseMaid,
          "grocery_assistant_amount":
              double.parse(info.bonusService.toString()),
        },
      );

      await Future.delayed(const Duration(milliseconds: 800));

      if (response.statusCode == 200) {
        int price = response.data['price'];
        print('price: $price');
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
