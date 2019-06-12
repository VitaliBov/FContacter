import 'package:equatable/equatable.dart';
import 'package:f_contacter/entity/user.dart';

abstract class ContactBlocEvent extends Equatable {
  ContactBlocEvent([List props = const []]) : super(props);
}

class ContactBlocEventLoad extends ContactBlocEvent {
  final User user;

  ContactBlocEventLoad(this.user) : super([user]);
}