import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:dio/dio.dart';
import 'package:rmservice/authentication_repository/login_model.dart';
import 'package:rmservice/login/models/user.dart';
import 'package:rmservice/utilities/constants/variable.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  inactive,
  error
}

class AuthenticationRepository {
  //ignore: close_sinks
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield await isLogged();
    yield* _controller.stream;
  }

  Future<AuthenticationStatus> isLogged() async {
    const storage = FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken") ?? "";
    try {
      bool hasExpired = JwtDecoder.isExpired(accessToken);
      if (!hasExpired) {
        _controller.add(AuthenticationStatus.authenticated);
        return AuthenticationStatus.authenticated;
      }
      return AuthenticationStatus.unauthenticated;
    } catch (_) {
      return AuthenticationStatus.unauthenticated;
    }
  }

  Future<LoginModel> logIn({
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
      baseUrl: debugServer,
      validateStatus: (status) {
        return status! < 500;
      },
    );
    final dio = Dio(options);
    try {
      final response = await dio.request("/user/login", data: body);
      print(jsonEncode(response.data));
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        LoginModel loginModel;
        // await storage.write(
        //     key: 'refreshToken',
        //     value: response.data['response']['tokens']['refresh']['token']);
        // await storage.write(
        //     key: 'uid',
        //     value: response.data['response']['user']['id'].toString());

        _controller.add(AuthenticationStatus.authenticated);
        await storage.write(key: 'token', value: response.data['token']);
        String token = await storage.read(key: 'token') ?? "";
        print('token got: $token');
        loginModel = LoginModel(
          status: AuthenticationStatus.authenticated,
          user: User.fromJson(response.data['user']),
        );

        var response2 = await dio.post('/user/${loginModel.user!.code!}/token',
            data: {'token': fcmToken});
        try {
          if (response2.data['code'] == 0) {
            debugPrint("post token success");
            return loginModel;
          } else {
            throw response2.data['message'];
          }
        } catch (e) {
          throw e.toString();
        }
      } else {
        if (response.data['code'] == 2) {
          //debugPrint(response.data['user']['status']);
          LoginModel loginModel = LoginModel(
            status: AuthenticationStatus.inactive,
          );
          return loginModel;
        }
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      }
    } catch (error) {
      print('test: ${error.toString()}');
      if (error is DioError &&
          error.response?.statusCode == HttpStatus.unauthorized) {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      } else {
        _controller.add(AuthenticationStatus.error);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.error,
        );
        return loginModel;
      }
    }
  }

  Future<void> logOut(String userCode) async {
    const storage = FlutterSecureStorage();
    // String refreshToken = await storage.read(key: 'refreshToken') ?? "";
    // var options = BaseOptions(
    //   contentType: 'application/json',
    //   method: 'POST',
    //   baseUrl: debugServer,
    // );
    // final dio = Dio(options);
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      // final response = await dio
      //     .request("/auth/logout", data: {"refreshToken": refreshToken});
      // if (response.statusCode == HttpStatus.noContent) //204
      // {
      var dio = Dio(
        BaseOptions(
          contentType: 'application/json',
          method: 'DELETE',
          baseUrl: debugServer,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      FacebookLogin facebookLogin = FacebookLogin();
      await facebookLogin.logOut();

      await storage.deleteAll();
      _controller.add(AuthenticationStatus.unauthenticated);

      var response2 = await dio.delete('/user/$userCode/token',
          queryParameters: {'token': fcmToken});
      try {
        if (response2.data['code'] == 0) {
          debugPrint("delete token success");
        } else {
          throw response2.data['message'];
        }
      } catch (e) {
        throw e.toString();
      }
    } catch (error) {
      await storage.deleteAll();
      debugPrint(error.toString());
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<LoginModel> logInOauthGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) {
      _controller.add(AuthenticationStatus.unauthenticated);
      LoginModel loginModel = LoginModel(
        status: AuthenticationStatus.unauthenticated,
      );
      return loginModel;
    }

    final body = {
      "email": account.email,
    };

    var options = BaseOptions(
      contentType: 'application/json',
      method: 'POST',
      baseUrl: debugServer,
      validateStatus: (status) {
        return status! < 500;
      },
    );

    final dio = Dio(options);

    try {
      final response = await dio.request("/user/oauth-login", data: body);
      print(jsonEncode(response.data));
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        LoginModel loginModel;
        // await storage.write(
        //     key: 'refreshToken',
        //     value: response.data['response']['tokens']['refresh']['token']);
        // await storage.write(
        //     key: 'uid',
        //     value: response.data['response']['user']['id'].toString());
        if (response.data['user']['status'] != "active") {
          debugPrint(response.data['user']['status']);
          loginModel = LoginModel(
            status: AuthenticationStatus.inactive,
          );
        } else {
          _controller.add(AuthenticationStatus.authenticated);
          await storage.write(key: 'token', value: response.data['token']);
          String token = await storage.read(key: 'token') ?? "";
          print('token got: $token');
          loginModel = LoginModel(
            status: AuthenticationStatus.authenticated,
            user: User.fromJson(response.data['user']),
          );

          var response2 = await dio.post(
              '/user/${loginModel.user!.code!}/token',
              data: {'token': fcmToken});
          try {
            if (response2.data['code'] == 0) {
              debugPrint("post token success");
              return loginModel;
            } else {
              throw response2.data['message'];
            }
          } catch (e) {
            throw e.toString();
          }
        }
        return loginModel;
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      }
    } catch (error) {
      print('test: ${error.toString()}');
      if (error is DioError &&
          error.response?.statusCode == HttpStatus.unauthorized) {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      } else {
        _controller.add(AuthenticationStatus.error);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.error,
        );
        return loginModel;
      }
    }
  }

  Future<LoginModel> logInOauthFacebook() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email == null) {
          _controller.add(AuthenticationStatus.unauthenticated);
          LoginModel loginModel = LoginModel(
            status: AuthenticationStatus.unauthenticated,
          );
          return loginModel;
        }
        break;
      default:
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
    }

    final body = {
      "email": await fb.getUserEmail(),
    };

    var options = BaseOptions(
      contentType: 'application/json',
      method: 'POST',
      baseUrl: debugServer,
      validateStatus: (status) {
        return status! < 500;
      },
    );

    final dio = Dio(options);

    try {
      final response = await dio.request("/user/oauth-login", data: body);
      print(jsonEncode(response.data));
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        LoginModel loginModel;
        // await storage.write(
        //     key: 'refreshToken',
        //     value: response.data['response']['tokens']['refresh']['token']);
        // await storage.write(
        //     key: 'uid',
        //     value: response.data['response']['user']['id'].toString());
        if (response.data['user']['status'] != "active") {
          debugPrint(response.data['user']['status']);
          loginModel = LoginModel(
            status: AuthenticationStatus.inactive,
          );
        } else {
          _controller.add(AuthenticationStatus.authenticated);
          await storage.write(key: 'token', value: response.data['token']);
          String token = await storage.read(key: 'token') ?? "";
          print('token got: $token');
          loginModel = LoginModel(
            status: AuthenticationStatus.authenticated,
            user: User.fromJson(response.data['user']),
          );

          var response2 = await dio.post(
              '/user/${loginModel.user!.code!}/token',
              data: {'token': fcmToken});
          try {
            if (response2.data['code'] == 0) {
              debugPrint("post token success");
              return loginModel;
            } else {
              throw response2.data['message'];
            }
          } catch (e) {
            throw e.toString();
          }
        }
        return loginModel;
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      }
    } catch (error) {
      print('test: ${error.toString()}');
      if (error is DioError &&
          error.response?.statusCode == HttpStatus.unauthorized) {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      } else {
        _controller.add(AuthenticationStatus.error);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.error,
        );
        return loginModel;
      }
    }
  }

  Future<LoginModel> autoLogin() async {
    try {
      const storage = FlutterSecureStorage();
      String token = await storage.read(key: "token") ?? "";
      debugPrint('token auto:' + token);
      if (token == "") {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unknown,
        );
        return loginModel;
      } else {
        Dio dio = Dio(
          BaseOptions(
            contentType: 'application/json',
            method: 'GET',
            baseUrl: debugServer,
            validateStatus: (status) {
              return status! < 500;
            },
          ),
        );
        var response =
            await dio.post('/user/login:auto', data: {'token': token});
        if (response.data['code'] == 0) {
          debugPrint("auto login success");
          _controller.add(AuthenticationStatus.authenticated);
          LoginModel loginModel = LoginModel(
            status: AuthenticationStatus.authenticated,
            user: User.fromJson(response.data['user']),
          );
          return loginModel;
        } else {
          _controller.add(AuthenticationStatus.unauthenticated);
          LoginModel loginModel = LoginModel(
            status: AuthenticationStatus.unauthenticated,
          );
          return loginModel;
        }
      }
    } catch (error) {
      //print('test: ${error.toString()}');
      if (error is DioError &&
          error.response?.statusCode == HttpStatus.unauthorized) {
        _controller.add(AuthenticationStatus.unauthenticated);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.unauthenticated,
        );
        return loginModel;
      } else {
        _controller.add(AuthenticationStatus.error);
        LoginModel loginModel = LoginModel(
          status: AuthenticationStatus.error,
        );
        return loginModel;
      }
    }
  }
}
