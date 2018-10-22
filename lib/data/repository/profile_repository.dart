import 'package:f_contacter/data/entity/user.dart';
import 'package:f_contacter/data/preference/preference.dart';

class ProfileRepository {
  static final _profileRepository = ProfileRepository._internal();

  ProfileRepository._internal();

  factory ProfileRepository() => _profileRepository;

  ProfilePrefs _profilePrefs = ProfilePrefs();

  void saveToken(String token) {
    _profilePrefs.setToken(token);
  }

  void saveUser(User user) {
    print('saveUser');
  }

  Future<bool> isAuthorized() async => _profilePrefs.isHaveToken();
}