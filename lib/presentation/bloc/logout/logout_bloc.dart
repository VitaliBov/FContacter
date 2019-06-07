import 'package:bloc/bloc.dart';
import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/presentation/bloc/logout/logout_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/logout/logout_bloc_state.dart';

class LogoutBloc extends Bloc<LogoutBlocEvent, LogoutBlocState> {
  ProfileRepository _profileRepository = ProfileRepository();
  AuthRepository _authRepository = AuthRepository();

  @override
  LogoutBlocState get initialState => LogoutBlocStateEmpty();

  @override
  Stream<LogoutBlocState> mapEventToState(LogoutBlocEvent event) async* {
    if (event is LogoutBlocEventLogout) {
      try {
        yield LogoutBlocStateLoading();
        //TODO clear database
        Future.wait([
          _authRepository.clearToken(),
          _profileRepository.clearProfileLocal()
        ]);
        yield LogoutBlocStateSuccess();
      } catch (error) {
        yield LogoutBlocStateError(error);
      }
    }
  }
}