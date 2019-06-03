import 'dart:async';

import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc implements BlocBase {
  AuthRepository _authRepository = AuthRepository();
  ProfileRepository _profileRepository = ProfileRepository();

  final BehaviorSubject<bool> _isUserSavedController = BehaviorSubject<bool>();
  StreamSink get _isUserSavedSink => _isUserSavedController.sink;
  Stream<bool> get isUserSaved => _isUserSavedController.stream;

  void authorization(String code) async {
    _isUserSavedSink.add(false);
    var authResult = await _authRepository.getTokenNetwork(code);
    Future.wait([_saveToken(authResult.token), _saveUser(authResult.user)])
        .then((authResult) => _isUserSavedSink.add(true))
        .catchError((e) => print("Error"));
  }

  Future _saveToken(String token) => _authRepository.saveToken(token);
  Future _saveUser(User user) => _profileRepository.saveProfileLocal(user);

  void dispose(){
    _isUserSavedController.close();
  }
}