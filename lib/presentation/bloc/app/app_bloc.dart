import 'package:bloc/bloc.dart';
import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/presentation/bloc/app/app_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/app/app_bloc_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AuthRepository _authRepository = AuthRepository();

  @override
  AppBlocState get initialState => AppBlocStateLoading();

  @override
  Stream<AppBlocState> mapEventToState(AppBlocEvent event) async* {
    if (event is AppBlocEventInit) {
      try {
        var isAuthorized = await _authRepository.isAuthorized();
        yield AppBlocStateSuccess(isAuthorized);
      } catch (error) {
        yield AppBlocStateSuccess(false);
      }
    } else {
      yield AppBlocStateSuccess(false);
    }
  }
}