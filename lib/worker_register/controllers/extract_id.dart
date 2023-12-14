import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_register/models/extract_id.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: extractIDServer,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
    headers: {
      'Content-Type': 'application/json',
      'Token-id': extractIDTokenID,
      'Token-key': extractIDTokenKey,
      'Authorization': extractIDAuthorization,
      'mac-address': 'TEST1'
    },
  ),
);

final dio2 = Dio(
  BaseOptions(
    baseUrl: extractIDServer,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    },
    headers: {
      'Content-Type': 'multipart/form-data',
      'Token-id': extractIDTokenID,
      'Token-key': extractIDTokenKey,
      'Authorization': extractIDAuthorization,
      'mac-address': 'TEST1'
    },
  ),
);

class ExtractIDCardController {
  Future<ExtractIDCard> extractIDCard(File idF, File idB) async {
    try {
      var response1 = await dio2.post(
        '/file-service/v1/addFile',
        data: FormData.fromMap({
          "file": await MultipartFile.fromFile(idF.path),
          "title": Random().nextInt(1000).toString(),
          "description": Random().nextInt(1000).toString(),
        }),
      );
      String idFHash = response1.data['object']['hash'];
      debugPrint(idFHash);

      var response2 = await dio2.post(
        '/file-service/v1/addFile',
        data: FormData.fromMap({
          "file": await MultipartFile.fromFile(idB.path),
          "title": Random().nextInt(1000).toString(),
          "description": Random().nextInt(1000).toString(),
        }),
      );
      String idBHash = response2.data['object']['hash'];
      debugPrint(idBHash);

      var response = await dio.post('/ai/v1/ocr/id', data: {
        "img_front": idFHash,
        "img_back": idBHash,
        "client_session":
            "IOS_iphone6plus_ios13_Device_1.3.6_CC332797-E3E5-475F-8546-C9C4AA348837_1581429032",
        "token": DateTime.timestamp().toString(),
        "type": -1,
        "validate_postcode": true,
        "crop_param": "0,1"
      });
      debugPrint(response.statusCode.toString());
      if (response.data["statusCode"] == 200) {
        ExtractIDCard extractIDCard = ExtractIDCard.fromJson(response.data['object']);
        return extractIDCard;
      } else {
        String message = jsonEncode(response.data['errors']);
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
