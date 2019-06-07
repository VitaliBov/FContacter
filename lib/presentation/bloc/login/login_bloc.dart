import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/bloc/login/login_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/login/login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  AuthRepository _authRepository = AuthRepository();
  ProfileRepository _profileRepository = ProfileRepository();

  @override
  LoginBlocState get initialState => LoginBlocStateEmpty();

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if (event is LoginBlocEventLogin) {
      try {
        yield LoginBlocStateLoading();
        var authResult = await _authRepository.getTokenNetwork(event.code);
        Future.wait([_saveToken(authResult.token), _saveUser(authResult.user)]);
        yield LoginBlocStateSuccess();
      } catch (error) {
        yield LoginBlocStateError(error);
      }
    }
  }

  Future _saveToken(String token) => _authRepository.saveToken(token);
  Future _saveUser(User user) => _profileRepository.saveProfileLocal(user);
}