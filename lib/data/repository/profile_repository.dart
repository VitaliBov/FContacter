import 'dart:async';
import 'package:f_contacter/data/mapper/user_mapper.dart';
import 'package:f_contacter/data/network/api_client.dart';
import 'package:f_contacter/data/preference/preference.dart';
import 'package:f_contacter/entity/user.dart';

class ProfileRepository {
  static final _profileRepository = ProfileRepository._internal();
  final ApiClient _apiClient = ApiClient();
  final ProfilePrefs _profilePrefs = ProfilePrefs();

  ProfileRepository._internal();
  factory ProfileRepository() => _profileRepository;

  Future<void> saveProfileLocal(User user) => _profilePrefs.setUser(user);
  Future<void> clearProfileLocal() => _profilePrefs.setUser(null);
  Future<User> getProfileLocal() => _profilePrefs.getUser();
  Future<User> getProfileNetwork() async => userResponseToUser((await _apiClient.gerCurrentUser()).user);
}