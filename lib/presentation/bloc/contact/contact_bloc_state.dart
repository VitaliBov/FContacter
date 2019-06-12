import 'package:equatable/equatable.dart';
import 'package:f_contacter/entity/user.dart';

class ContactBlocState extends Equatable {
  ContactBlocState([List props = const []]) : super(props);
}

class ContactBlocStateLoading extends ContactBlocState {}

class ContactBlocStateSuccess extends ContactBlocState {
  final User user;

  ContactBlocStateSuccess(this.user) : super([user]);
}

class ContactBlocStateError extends ContactBlocState {
  Exception exception;

  ContactBlocStateError(this.exception) : super([exception]);
}