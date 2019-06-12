import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:f_contacter/data/repository/status_repository.dart';
import 'package:f_contacter/data/repository/users_repository.dart';
import 'package:f_contacter/presentation/bloc/contact/contact_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/contact/contact_bloc_state.dart';

class ContactBloc extends Bloc<ContactBlocEvent, ContactBlocState> {
  UsersRepository _profileRepository = UsersRepository();
  StatusRepository _statusRepository = StatusRepository();

  @override
  ContactBlocState get initialState => ContactBlocStateLoading();

  @override
  Stream<ContactBlocState> mapEventToState(ContactBlocEvent event) async* {
    if (event is ContactBlocEventLoad) {
      try {
        var networkUser = await  _profileRepository.getUserFromNetwork(int.parse(event.user.id));
        networkUser.status = await _statusRepository.getUserStatusFromNetwork(int.parse(event.user.id), event.user.name);
        yield ContactBlocStateSuccess(networkUser);
      } catch (error) {
        yield ContactBlocStateError(error);
      }
    }
  }
}