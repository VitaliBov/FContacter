import 'package:f_contacter/data/entity/user.dart';

class ProfileRepository {
  static final _profileRepository = ProfileRepository._internal();

  ProfileRepository._internal();

  factory ProfileRepository() => _profileRepository;

  void saveToken(String token) {
    print('saveToken');
  }

  void saveUser(User user) {
    print('saveUser');
  }
}