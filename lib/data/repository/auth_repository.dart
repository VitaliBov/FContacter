import 'package:f_contacter/data/entity/auth.dart';
import 'package:f_contacter/data/mapper/user_mapper.dart';
import 'package:f_contacter/data/network/api_client.dart';
import 'package:f_contacter/data/network/request/auth_request.dart';

class AuthRepository {
  static final _authRepository = AuthRepository._internal();

  AuthRepository._internal();

  factory AuthRepository() => _authRepository;

  ApiClient _apiClient = ApiClient();

  Future<Auth> getToken(String code) async {
    var response = await _apiClient.getToken(AuthRequest(code));
    var user = toUser(response);
    var token = response.accessToken;
    return Auth(token, user);
  }
}