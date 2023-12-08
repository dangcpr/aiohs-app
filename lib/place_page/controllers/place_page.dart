import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/place_page/models/rental_place.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/place_page/models/rental_place_result.dart';
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

class PlacePageController {
  Future<void> createPlaceRental(
      RentalPlace rentalPlace, String userCode) async {
    try {
      var response = await dio.post(
        '/user/$userCode/area-booking/create',
        data: jsonEncode(rentalPlace),
      );
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

  Future<List<RentalPlaceRes>> getRental(String userCode) async {
    try {
      var response = await dio.get(
        '/user/$userCode/area-booking',
      );
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        List<RentalPlaceRes> rentalPlaceRes = (response.data['posts'] as List)
            .map((e) => RentalPlaceRes.fromJson(e))
            .toList();
        return rentalPlaceRes;
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

  Future<List<RentalPlaceRes>> getRentalInactive(String userCode) async {
    try {
      var response = await dio.get(
        '/user/$userCode/area-booking',
        queryParameters: {
          'status': 'AREA_BOOKING_STATUS_INACTIVE',
        }
      );
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        List<RentalPlaceRes> rentalPlaceRes = (response.data['posts'] as List)
            .map((e) => RentalPlaceRes.fromJson(e))
            .toList();
        return rentalPlaceRes;
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

  Future<RentalPlaceResult> getRentalPublic(String userCode, String next, int limit, double distance ) async {
    try {
      var response = await dio.get(
        '/user/$userCode/area-booking/public',
        queryParameters: {
          "next": next,
          "limit": limit,
          "distance": distance
        }
      );
      await Future.delayed(const Duration(milliseconds: 800));
      if (response.data['code'] == 0) {
        List<RentalPlaceRes> rentalPlaceRes = (response.data['posts'] as List)
            .map((e) => RentalPlaceRes.fromJson(e))
            .toList();
        String next = response.data['next'];
        return RentalPlaceResult(
          next: next,
          rentalPlaceRes: rentalPlaceRes
        );
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

  Future<void> updateRental(RentalPlace rentalPlace, String code, String userCode) async {
    try {
      var response = await dio.post(
        '/user/$userCode/area-booking/$code/update',
        data: jsonEncode(rentalPlace),
      );
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

  Future<void> cancelRental(RentalPlaceRes rentalPlace, String userCode) async {
    try  {
      var response = await dio.get(
        '/user/$userCode/area-booking/${rentalPlace.code}/close'
      );
      await Future.delayed(const Duration(milliseconds: 800));
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
