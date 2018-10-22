import 'package:shared_preferences/shared_preferences.dart';

class ProfilePrefs {
  static const _tokenKey = 'token key';
  static final _profilePrefs= ProfilePrefs._internal();
  ProfilePrefs._internal();

  factory ProfilePrefs() => _profilePrefs;

  Future<bool> isHaveToken() async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tokenKey, token);
  }
}