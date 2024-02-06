import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/payment/models/zalopay.dart';
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

class ZalopayController {
  Future<Zalopay> createOrder({
    required String userCode,
    required String orderCode,
  }) async {
    try {
      final response =
          await dio.post('/user/$userCode/orders/$orderCode/payment/zalopay');

      if (response.data['code'] == 0) {
        debugPrint(response.data['payment_url']);
        return Zalopay.fromJson(response.data);
      } else {
        throw response.data['message'];
      }
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<int> verifyOrder({
    required String userCode,
    required String refID,
  }) async {
    try {
      final response = await dio.get(
        '/user/$userCode/orders/payment/$refID/status',
      );

      if (response.data['code'] == 0) {
        return response.data['status'];
      } else {
        return 2;
      }
      
    } catch (e) {
      debugPrint(e.toString());
      return 2;
    }
  }
}
