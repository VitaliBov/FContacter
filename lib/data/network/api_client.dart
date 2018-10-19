import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:f_contacter/data/network/request/auth_request.dart';
import 'package:f_contacter/data/network/response/auth_response.dart';

class ApiClient {
  static const String baseUrl = 'https://orangesoft.teamworkpm.net';
  static final _client = ApiClient._internal();
  final JsonDecoder _decoder = new JsonDecoder();

  ApiClient._internal();

  factory ApiClient() => _client;

  Future<dynamic> _get(String url) {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> _post(String url, {Map<String, String> headers, body, encoding}) {
    return http.post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print('"Status code: $statusCode. Response: $res"');
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data. Status code: $statusCode. Response: $res");
      }
      return _decoder.convert(res);
    });
  }

  Future<AuthResponse> getToken(AuthRequest request) async {
    var url = 'https://www.teamwork.com/launchpad/v1/token.json';
    var headers = {"Content-Type": "application/json"};
    var body = json.encode(request.toJson());
    print(request.toJson());
    final response = await http.post(url, headers: headers, body: body);
    final responseJson = json.decode(response.body);
    print('Response: $responseJson');
    return AuthResponse.fromJson(responseJson);
  }
}
