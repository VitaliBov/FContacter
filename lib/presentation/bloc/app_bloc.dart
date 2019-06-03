import 'dart:async';

import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/presentation/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc implements BlocBase {
  AuthRepository _authRepository = AuthRepository();

  AppBloc() {
    _checkAuthorization();
  }

  final BehaviorSubject<bool> _authController = BehaviorSubject<bool>();
  Stream<bool> get isAuthorized => _authController.stream;

  void dispose(){
    _authController.close();
  }

  void _checkAuthorization() {
    _authRepository.isAuthorized().then((isAuthorized) {
      _authController.sink.add(isAuthorized);
    });
  }
}