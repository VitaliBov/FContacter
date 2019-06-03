import 'dart:convert';

import 'package:f_contacter/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePrefs {
  static const _tokenKey = 'token key';
  static const _userKey = 'user key';
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

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJson = prefs.getString(_userKey);
    var userMap = json.decode(userJson);
    return User.fromJson(userMap);
  }

  Future<bool> setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJson = json.encode(user.toJson());
    return prefs.setString(_userKey, userJson);
  }
}