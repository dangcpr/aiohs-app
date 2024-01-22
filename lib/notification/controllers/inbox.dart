import 'package:dio/dio.dart';
import 'package:rmservice/utilities/constants/handle_error.dart';
import 'package:rmservice/notification/models/inbox.dart';
import 'package:rmservice/utilities/constants/variable.dart';

final dio =  Dio(
  BaseOptions(
    baseUrl: debugServer,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    validateStatus: (status) {
      return status! < 500;
    }
  )
);

class InboxController {
  Future<List<Inbox>> getInbox(String userCode) async {
    try {
      final response = await dio.get('/user/$userCode/inbox');
      //await Future.delayed(const Duration(seconds: 1));
      if (response.data['code'] == 0) {
        List<Inbox> inboxes = [];
        for (var inbox in response.data['inboxes']) {
          inboxes.add(Inbox.fromJson(inbox));
        }
        return inboxes;
      } else {
        throw response.data['message'];
      }
    } on DioException catch (e) {
      throw handleError(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> readed(String userCode, String inboxCode) async {
    try {
      final response = await dio.post('/user/$userCode/inbox/$inboxCode');
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

  Future<void> readedAll(String userCode) async {
    try {
      final response = await dio.post('/user/$userCode/inbox:opened-all');
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

  Future<void> deleteAll(String userCode) async {
    try {
      final response = await dio.delete('/user/$userCode/inbox');
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