import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:rmservice/maid_near/models/maid_rating.dart';
import 'package:rmservice/maid_near/models/maid_rating_result.dart';
import 'package:rmservice/maid_near/models/maid_res.dart';
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

class MaidInfoController {
  Future<List<MaidRes>> getMaidAround(String userCode) async {
    try {
      var response = await dio.get('/user/$userCode/maid-around', queryParameters: {
        "distance": 5,
        "star": 0.1,
      });
      if (response.data['code'] == 0) {
        List<MaidRes> maidList = [];
        maidList = (response.data['maids'] as List)
            .map((e) => MaidRes.fromJson(e))
            .toList();
        return maidList;
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
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

    Future<MaidRatingResult> getRatings(String userCode, String maidCode, int limit, String next) async {
    try {
      var response = await dio.get('/user/$userCode/maid-around/$maidCode/ratings', queryParameters: {
        "limit": limit,
        "next": next,
      });
      await Future.delayed(const Duration(milliseconds: 500));
      if (response.data['code'] == 0) {
        List<MaidRatingRes> maidList = [];
        maidList = (response.data['ratings'] as List)
            .map((e) => MaidRatingRes.fromJson(e)).toList();
        MaidRatingResult maidRatingResult = MaidRatingResult(
          listMaidRating: maidList,
          next: response.data['next'],
        );
        return maidRatingResult;
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
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
