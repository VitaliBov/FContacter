import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/data/repository/status_repository.dart';
import 'package:f_contacter/presentation/bloc/profile/profile_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/profile/profile_bloc_state.dart';

class ProfileBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  ProfileRepository _profileRepository = ProfileRepository();
  StatusRepository _statusRepository = StatusRepository();

  @override
  ProfileBlocState get initialState => ProfileBlocStateLoading();

  @override
  Stream<ProfileBlocState> mapEventToState(ProfileBlocEvent event) async* {
    if (event is ProfileBlocEventLoad) {
      try {
        var localUser = await _profileRepository.getProfileLocal();
        yield ProfileBlocStateSuccess(localUser);

        var networkUser = await  _profileRepository.getProfileNetwork();
        networkUser.status = await _statusRepository.getCurrentUserStatusFromNetwork();
        yield ProfileBlocStateSuccess(networkUser);

        _profileRepository.saveProfileLocal(networkUser);
      } catch (error) {
        yield ProfileBlocStateError(error);
      }
    }
  }
}