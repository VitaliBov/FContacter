import 'package:equatable/equatable.dart';

class AppBlocState extends Equatable {
  AppBlocState([List props = const []]) : super(props);
}

class AppBlocStateLoading extends AppBlocState {}

class AppBlocStateSuccess extends AppBlocState {
  bool isAuthorized;

  AppBlocStateSuccess(this.isAuthorized): super([isAuthorized]);
}