import 'package:equatable/equatable.dart';

abstract class LogoutBlocEvent extends Equatable {
  LogoutBlocEvent([List props = const []]) : super(props);
}

class LogoutBlocEventLogout extends LogoutBlocEvent {}