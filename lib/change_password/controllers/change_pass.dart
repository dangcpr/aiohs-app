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

class ChangePassController {
  Future<void> changePass({
    required String userCode,
    required String oldPass,
    required String newPass,
  }) async {
    try {
      var response = await dio.post(
        '/user/info/password-change',
        data: {
          'user_code': userCode,
          'old_password': oldPass,
          'new_password': newPass,
        },
      );
      if (response.data['code'] == 0) {
        return;
      } else {
        throw response.data['message'];
      }
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }
}