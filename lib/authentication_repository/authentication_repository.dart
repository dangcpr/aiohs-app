import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, error }

class AuthenticationRepository {
  final baseUrl = 'http://192.168.74.130:9000';

  //ignore: close_sinks
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield await isLogged();
    yield* _controller.stream;
  }

  Future<AuthenticationStatus> isLogged() async {
    const storage = FlutterSecureStorage();
    String refreshToken = await storage.read(key: "refreshToken") ?? "";
    try {
      bool hasExpired = JwtDecoder.isExpired(refreshToken);
      if (!hasExpired) {
        _controller.add(AuthenticationStatus.authenticated);
        return AuthenticationStatus.authenticated;
      }
      return AuthenticationStatus.unauthenticated;
    } catch (_) {
      return AuthenticationStatus.unauthenticated;
    }
  }

  Future<AuthenticationStatus> logIn({
    required String username,
    required String password,
  }) async {
    final body = {
      "email": username,
      "password": password,
    };
    var options = BaseOptions(
      contentType: 'application/json',
      method: 'POST',
      baseUrl: baseUrl,
    );
    final dio = Dio(options);
    try {
      final response = await dio.request("/user/login", data: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: response.data['token']);
        String token = await storage.read(key: 'token') ?? "";
        print('token got: $token');
        // await storage.write(
        //     key: 'refreshToken',
        //     value: response.data['response']['tokens']['refresh']['token']);
        // await storage.write(
        //     key: 'uid',
        //     value: response.data['response']['user']['id'].toString());
        _controller.add(AuthenticationStatus.authenticated);
        return AuthenticationStatus.authenticated;
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        return AuthenticationStatus.unauthenticated;
      }
    } catch (error) {
      print('test: ${error.toString()}');
      if (error is DioError &&
          error.response?.statusCode == HttpStatus.unauthorized) {
        _controller.add(AuthenticationStatus.unauthenticated);
        return AuthenticationStatus.unauthenticated;
      } else {
        _controller.add(AuthenticationStatus.error);
        return AuthenticationStatus.error;
      }
    }
  }

  Future<void> logOut() async {
    const storage = FlutterSecureStorage();
    String refreshToken = await storage.read(key: 'refreshToken') ?? "";
    var options = BaseOptions(
      contentType: 'application/json',
      method: 'POST',
      baseUrl: baseUrl,
    );
    final dio = Dio(options);
    try {
      final response = await dio
          .request("/auth/logout", data: {"refreshToken": refreshToken});
      if (response.statusCode == HttpStatus.noContent) //204
      {
        await storage.deleteAll();
        _controller.add(AuthenticationStatus.unauthenticated);
      } else {
        await storage.deleteAll();
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } catch (error) {
      await storage.deleteAll();
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }
}
