import 'package:f_contacter/data/network/dio_config.dart';
import 'package:f_contacter/data/network/request/status_request.dart';
import 'package:f_contacter/data/network/response/base_response.dart';
import 'package:f_contacter/data/network/response/status_response.dart';
import 'package:dio/dio.dart';

import 'package:f_contacter/data/network/request/auth_request.dart';
import 'package:f_contacter/data/network/response/auth_response.dart';
import 'package:f_contacter/data/network/response/users_response.dart';

class ApiClient {
  static const String baseUrl = 'https://orangesoft.teamworkpm.net/';
  final Dio _dio = DioConfig().dio;
  static final _client = ApiClient._internal();

  ApiClient._internal();

  factory ApiClient() => _client;

  //TODO add response error

  //Auth
  Future<AuthResponse> getToken(AuthRequest request) async {
    var url = 'https://www.teamwork.com/launchpad/v1/token.json';
    try {
      Response response = await _dio.post(
          url,
          data: request.toJson()
      );
      return AuthResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  //Users
  Future<UsersResponse> gerUsers(int companyId) async {
    var url = baseUrl + 'companies/$companyId/people.json';
    try {
      Response response = await _dio.get(url);
      return UsersResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  Future<UserResponse> gerUser(int id) async {
    var url = baseUrl + 'people/$id.json';
    try {
      Response response = await _dio.get(url);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  //Statuses
  Future<StatusesResponse> gerStatuses() async {
    var url = baseUrl + 'people/status.json';
    try {
      Response response = await _dio.get(url);
      return StatusesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  Future<StatusResponse> gerStatus(int userId) async {
    var url = baseUrl + 'people/$userId/status.json';
    try {
      Response response = await _dio.get(url);
      return StatusResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  //Current user
  Future<UserResponse> gerCurrentUser() async {
    var url = baseUrl + 'me.json';
    try {
      Response response = await _dio.get(url);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  Future<StatusResponse> gerCurrentUserStatus() async {
    var url = baseUrl + 'me/status.json';
    try {
      Response response = await _dio.get(url);
      return StatusResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }

  Future<BaseResponse> createCurrentUserStatus(StatusRequest request) async {
    var url = baseUrl + 'me/status.json';
    try {
      Response response = await _dio.post(url, data: request.toJson());
      return BaseResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      //TODO set exception
      throw Exception();
    }
  }
}