import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
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

class WorkerRegisterController {
  Future<int> register(
    String user_code,
    String full_name,
    String identiny_no,
    String issued_on,
    String permanent_address,
    String date_of_birth,
    String place_of_birth,
    File identity_front_image_url,
    File identity_back_image_url,
    String contact_address,
  ) async {
    try {
      String idFPath = await uploadImage(identity_front_image_url);
      String idBPath = await uploadImage(identity_back_image_url);
      debugPrint(idFPath);
      var response = await dio.post(
        '/user/$user_code/maid-registration',
        data: {
          "full_name": full_name,
          "identity_no": identiny_no,
          "issued_on": Jiffy.parse(issued_on, pattern: 'dd/MM/yyyy')
              .format(pattern: 'yyyy-MM-dd'),
          "permanent_address": permanent_address,
          "date_of_birth": Jiffy.parse(date_of_birth, pattern: 'dd/MM/yyyy')
              .format(pattern: 'yyyy-MM-dd'),
          "place_of_birth": place_of_birth,
          "identity_front_image_url": idFPath,
          "identity_back_image_url": idBPath,
          "contact_address": contact_address,
        },
      );
      if (response.data['code'] == 0) {
        return 1;
      } else {
        try {
          var response2 = await dio.put(
            '/user/$user_code/maid-registration',
            data: {
              "full_name": full_name,
              "identity_no": identiny_no,
              "issued_on": Jiffy.parse(issued_on, pattern: 'dd/MM/yyyy')
                  .format(pattern: 'yyyy-MM-dd'),
              "permanent_address": permanent_address,
              "date_of_birth": Jiffy.parse(date_of_birth, pattern: 'dd/MM/yyyy')
                  .format(pattern: 'yyyy-MM-dd'),
              "place_of_birth": place_of_birth,
              "identity_front_image_url": idFPath,
              "identity_back_image_url": idBPath,
              "contact_address": contact_address,
            },
          );
          if (response2.data['code'] == 0) {
            return 2;
          } else {
            throw response2.data['message'];
          }
        } catch (e) {
          debugPrint(e.toString());
          throw e.toString();
        }
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
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
