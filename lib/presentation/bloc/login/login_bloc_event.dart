import 'package:equatable/equatable.dart';

abstract class LoginBlocEvent extends Equatable {
  LoginBlocEvent([List props = const []]) : super(props);
}

class LoginBlocEventLogin extends LoginBlocEvent {
  final String code;

  LoginBlocEventLogin(this.code) : super([code]);
}