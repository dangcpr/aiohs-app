import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/shopping/models/address_shopping.dart';
import 'package:rmservice/shopping/models/info_shopping.dart';
import 'package:rmservice/shopping/models/shopping_price.dart';
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

class ShoppingController {
  Future<ShoppingPrice> getShoppingPrice() async {
    try {
      var response = await dio.get('/user/products/GROCERY_ASSISTANT');
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        ShoppingPrice shoppingPrice =
            ShoppingPrice.fromJson(response.data['price']);
        return shoppingPrice;
      } else {
        String message = response.data['message'];
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

  Future<void> orderShopping(
      InfoShopping info, AddressShopping address, String userCode) async {
    try {
      var response = await dio
          .post('/user/$userCode/orders/grocery-assistant/create', data: {
        "order_amount": info.price! + info.purchaseFee!,
        "payment_method": info.paymentMethod,
        "working_date":
            '${info.date!.year}-${info.date!.month}-${info.date!.day}',
        "working_hour":
            '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
        "working_address": '${address.nameAddress!}-${address.fullAddress}',
        "items": info.listItems,
        "amount": info.price!,
        "purchase_fee": info.purchaseFee!,
        "note": info.note
      });
      if (response.data['code'] == 0) {
        return;
      } else {
        String message = response.data['message'];
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
