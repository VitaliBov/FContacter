import 'dart:async';

import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/entity/user.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class ProfileBloc implements BlocBase {
  ProfileRepository _profileRepository = ProfileRepository();
  AuthRepository _authRepository = AuthRepository();

  ProfileBloc() {
    _loadUser();
  }

  final BehaviorSubject<User> _userController = BehaviorSubject<User>();
  StreamSink<User> get _userSink => _userController.sink;
  Stream<User> get getUser => _userController.stream;

  final BehaviorSubject<bool> _logoutController = BehaviorSubject<bool>();
  StreamSink<bool> get _logoutSink => _logoutController.sink;
  Stream<bool> get isLogout => _logoutController.stream;

  void logout() {
    //TODO clear database
    Future.wait([
      _authRepository.clearToken(),
      _profileRepository.clearProfileLocal()
    ])
        .then((logoutResult) => _logoutSink.add(true));
  }

  void _loadUser() {
    //TODO add loading state
    _userSink.add(null);
    _profileRepository.getProfileLocal()
        .then((user) => _userSink.add(user))
        .whenComplete(() {
          _profileRepository.getProfileNetwork()
              .then((user) => _userSink.add(user));
        });
  }

  @override
  void dispose() {
    _userController.close();
    _logoutController.close();
  }
}