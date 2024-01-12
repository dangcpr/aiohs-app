import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/shopping/models/address_shopping.dart';
import 'package:rmservice/shopping/models/info_shopping.dart';
import 'package:rmservice/shopping/models/product_buy_request.dart';
import 'package:rmservice/shopping/models/shopping_price.dart';
import 'package:rmservice/utilities/constants/function.dart';
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
    List<ProductBuyRequest> productBuyRequest = [];

    //add items to buy request (because images is files so we need to upload it first)
    for (var items in info.listItems!) {
      List<String> listImages = [];
      for (var imageItem in items.listImages) {
        listImages.add(await uploadImage(imageItem));
      }
      productBuyRequest.add(
        ProductBuyRequest(
          item: items.name,
          images: listImages,
        ),
      );
    }
    try {
      var response = await dio
          .post('/user/$userCode/orders/grocery-assistant/create', data: {
        "order_amount": info.price!,
        "payment_method": info.paymentMethod,
        "working_date":
            '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
        "working_hour":
            '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
        "working_address": '${address.nameAddress!}-${address.fullAddress}',
        "latitude": address.latCurrent,
        "longitude": address.lngCurrent,
        "items": productBuyRequest.map((e) => e.toJson()).toList(),
        "amount": info.price!,
        "purchase_fee": info.purchaseFee!,
        "note": info.note,
        "agent_name": address.yourName,
        "agent_phone": address.phoneNum,
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

  Future<int> caculateShopping(InfoShopping info) async {
    try {
      var response = await dio
          .post('/user/orders/grocery-assistant/prices/calculate', data: {
        "working_date":
            '${info.date!.year.toString().padLeft(4, '0')}-${info.date!.month.toString().padLeft(2, '0')}-${info.date!.day.toString().padLeft(2, '0')}',
        "working_hour":
            '${info.time!.hour.toString().padLeft(2, '0')}:${info.time!.minute.toString().padLeft(2, '0')}:00',
        "amount": info.price! + info.purchaseFee!,
        "number_items": info.listItems!.length,
      });

      await Future.delayed(const Duration(milliseconds: 800));

      if (response.statusCode == 200) {
        int price = response.data['price'];
        debugPrint(price.toString());
        return price;
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
