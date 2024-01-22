import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String handleError(DioException e) {
  debugPrint(e.type.toString());
  if (e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.connectionTimeout) {
    return 'Connection Timeout';
  }

  if (e.type == DioExceptionType.unknown ||
      e.type == DioExceptionType.connectionError) {
    return 'Internet Error or Server Error';
  }
  debugPrint(e.type.toString());
  return 'Server Error';
}
