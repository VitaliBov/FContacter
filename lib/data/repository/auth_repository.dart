import 'package:f_contacter/data/mapper/user_mapper.dart';
import 'package:f_contacter/data/network/api_client.dart';
import 'package:f_contacter/data/network/request/auth_request.dart';
import 'package:f_contacter/data/preference/preference.dart';
import 'package:f_contacter/entity/auth.dart';

class AuthRepository {
  static final _authRepository = AuthRepository._internal();
  final ApiClient _apiClient = ApiClient();
  final ProfilePrefs _profilePrefs = ProfilePrefs();

  AuthRepository._internal();

  factory AuthRepository() => _authRepository;

  Future<Auth> getTokenNetwork(String code) async {
    var response = await _apiClient.getToken(AuthRequest(code));
    var user = authResponseToUser(response);
    var token = response.accessToken;
    return Auth(token, user);
  }

  Future<bool> isAuthorized() async => _profilePrefs.isHaveToken();
  Future<String> getTokenLocal(String code) => _profilePrefs.getToken();
  Future<void> saveToken(String token) async => await _profilePrefs.setToken(token);
  Future<void> clearToken() async => await saveToken(null);
}