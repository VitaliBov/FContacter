import 'package:equatable/equatable.dart';

class LogoutBlocState extends Equatable {
  LogoutBlocState([List props = const []]) : super(props);
}

class LogoutBlocStateEmpty extends LogoutBlocState {}

class LogoutBlocStateLoading extends LogoutBlocState {}

class LogoutBlocStateSuccess extends LogoutBlocState {}

class LogoutBlocStateError extends LogoutBlocState {
  Exception exception;

  LogoutBlocStateError(this.exception) : super([exception]);
}