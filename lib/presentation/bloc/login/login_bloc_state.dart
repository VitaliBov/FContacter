import 'package:equatable/equatable.dart';

class LoginBlocState extends Equatable {
  LoginBlocState([List props = const []]) : super(props);
}

class LoginBlocStateEmpty extends LoginBlocState {}

class LoginBlocStateLoading extends LoginBlocState {}

class LoginBlocStateSuccess extends LoginBlocState {}

class LoginBlocStateError extends LoginBlocState {
  Exception exception;

  LoginBlocStateError(this.exception) : super([exception]);
}