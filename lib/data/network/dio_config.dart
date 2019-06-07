import 'dart:io';

import 'package:dio/dio.dart';
import 'package:f_contacter/data/preference/preference.dart';

class DioConfig {
  static const int TIMEOUT_DEFAULT = 8000;
  static final _dioConfig = DioConfig._internal();
  Dio _dio;
  final ProfilePrefs _profilePrefs = ProfilePrefs();

  DioConfig._internal() {
    _dio = Dio();
    _dio.options.contentType = ContentType.json;
    _dio.options.responseType = ResponseType.json;
    _dio.options.sendTimeout = TIMEOUT_DEFAULT;
    _dio.options.receiveTimeout = TIMEOUT_DEFAULT;
    _dio.options.connectTimeout = TIMEOUT_DEFAULT;
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (Options options) async {
          String token = 'Bearer ${await _profilePrefs.getToken()}';
          options.headers[HttpHeaders.authorizationHeader] = token;
          return options;
        }
    ));
  }

  factory DioConfig() => _dioConfig;

  Dio get dio => _dio;
}