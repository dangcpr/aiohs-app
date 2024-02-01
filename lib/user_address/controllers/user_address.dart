import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/user_address/models/address_response.dart';
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

class UserAddressController {
  Future<List<AddressResponse>> getAddress(String userCode) async {
    try {
      var response = await dio.get('/user/$userCode/address');
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        List<AddressResponse> address = [];
        debugPrint(response.data['results'].toString());
        address = (response.data['results'] as List)
            .map((e) => AddressResponse.fromJson(e))
            .toList();
        return address;
      } else {
        if (response.data['code'] == 3) {
          return [];
        }
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

  Future<void> addAddress(Address address, String userCode, bool isDefault) async {
    try {
      var response = await dio.post('/user/$userCode/address', data: {
        "type": address.typeOfAddress,
        "city": address.city,
        "district": address.district,
        "ward": "",
        "street_name": address.address,
        "house_no": "",
        "latitude": address.latitude,
        "longitude": address.longitude,
        "detail": address.shortAddress,
        "agent_name": address.name,
        "agent_phone": address.phone,
        "is_default": isDefault,
      });
      await Future.delayed(const Duration(milliseconds: 800));
      debugPrint(jsonEncode(response.data));
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
