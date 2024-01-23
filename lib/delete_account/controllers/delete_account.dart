import 'package:dio/dio.dart';
import 'package:rmservice/utilities/constants/handle_error.dart';
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

class DeleteAccountController {
  Future<void> deleteAccount(String userCode) {
    try {
      return dio.delete('/user/$userCode/info/delete');
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }
}