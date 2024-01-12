import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/login/models/user.dart';

import '../../utilities/constants/function.dart';
import '../../utilities/constants/variable.dart';
import '../models/history_job_posting.dart';
import '../models/post_job_info.dart';
import '../models/post_result.dart';

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

class PostJobRepo {
  Future<void> postJob(
      String usercode, PostJobInfo postJobInfo, List<File> imagesFile) async {
    print('Test: ${postJobInfo.toJson().toString()}');
    try {
      List<String> images = [];
      for (var i = 0; i < imagesFile.length; i++) {
        String path = await uploadImage(imagesFile[i]);
        images.add(path);
      }
      postJobInfo.images = images;
      final response = await dio.post(
        '/user/$usercode/job-posting/create',
        data: {
          "longitude": postJobInfo.longitude,
          "latitude": postJobInfo.latitude,
          "working_address": postJobInfo.workingAddress,
          "title": postJobInfo.title,
          "number_employee": postJobInfo.numberEmployee,
          "description": postJobInfo.description,
          "wage_type": postJobInfo.wageType,
          "wage_min": postJobInfo.wageMin,
          "wage_max": postJobInfo.wageMax,
          "images": postJobInfo.images,
          "candidate_gender": postJobInfo.candidateGender,
          "candidate_min_age": postJobInfo.candidateMinAge,
          "candidate_max_age": postJobInfo.candidateMaxAge,
          "candidate_experience": postJobInfo.candidateExperience
        },
      );
      if (response.data['code'] == 0) {
        print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        print(response.statusCode);
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

  Future<HistoryJobPosting> updatePost(String usercode, PostJobInfo postJobInfo,
      String jobCode, List<File> imagesFile) async {
    try {
      List<String> images = [];
      for (var i = 0; i < imagesFile.length; i++) {
        String path = await uploadImage(imagesFile[i]);
        images.add(path);
      }
      postJobInfo.images = images;
      final response = await dio.post(
        '/user/$usercode/job-posting/$jobCode/update',
        data: {
          "longitude": postJobInfo.longitude,
          "latitude": postJobInfo.latitude,
          "working_address": postJobInfo.workingAddress,
          "title": postJobInfo.title,
          "number_employee": postJobInfo.numberEmployee,
          "description": postJobInfo.description,
          "wage_type": postJobInfo.wageType,
          "wage_type_display": postJobInfo.wageTypeDisplay,
          "wage_min": postJobInfo.wageMin,
          "wage_max": postJobInfo.wageMax,
          "images": postJobInfo.images,
          "candidate_gender": postJobInfo.candidateGender,
          "candidate_min_age": postJobInfo.candidateMinAge,
          "candidate_max_age": postJobInfo.candidateMaxAge,
          "candidate_experience": postJobInfo.candidateExperience
        },
      );
      if (response.data['code'] == 0) {
        print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        print(response.data['job']);
        return HistoryJobPosting.fromJson(response.data['job']);
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

  Future<PostResult> getPost(String userCode, String status) async {
    try {
      final response = await dio.get(
        '/user/$userCode/job-posting',
        queryParameters: {'status': status},
      );

      await Future.delayed(const Duration(milliseconds: 500));
      if (response.data['code'] == 0) {
        List<HistoryJobPosting> posts = [];

        posts = (response.data['jobs'] as List)
            .map((e) => HistoryJobPosting.fromJson(e))
            .toList();

        debugPrint(posts.length.toString());

        print(
            "-------------------------------------------------------------------------------");
        print('data reponse: ${response.data}');
        print(
            "-------------------------------------------------------------------------------");

        return PostResult(posts, 0);
      } else {
        throw response.data['message'];
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

  Future<PostResult> getPostAll(
      double distance, String userCode, int next) async {
    try {
      final response = await dio.get(
        '/user/$userCode/job-posting/public',
        queryParameters: {"distances": distance, "limit": 15, "next": next},
      );
      await Future.delayed(const Duration(milliseconds: 500));
      if (response.data['code'] == 0) {
        List<HistoryJobPosting> posts = [];
        posts = (response.data['jobs'] as List)
            .map((e) => HistoryJobPosting.fromJson(e))
            .toList();

        debugPrint(posts.length.toString());

        print(
            "-------------------------------------------------------------------------------");
        print('data reponse: ${response.data}');
        print(
            "-------------------------------------------------------------------------------");

        return PostResult(posts, int.tryParse(response.data['next'])!);
      } else {
        throw response.data['message'];
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

  Future<void> postClose(String userCode, String jobCode) async {
    try {
      final response =
          await dio.get('/user/$userCode/job-posting/$jobCode/close');
      await Future.delayed(const Duration(milliseconds: 500));
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
