import 'package:equatable/equatable.dart';
import 'package:f_contacter/entity/user.dart';

class ProfileBlocState extends Equatable {
  ProfileBlocState([List props = const []]) : super(props);
}

class ProfileBlocStateLoading extends ProfileBlocState {}

class ProfileBlocStateSuccess extends ProfileBlocState {
  final User user;

  ProfileBlocStateSuccess(this.user) : super([user]);
}

class ProfileBlocStateError extends ProfileBlocState {
  Exception exception;

  ProfileBlocStateError(this.exception) : super([exception]);
}