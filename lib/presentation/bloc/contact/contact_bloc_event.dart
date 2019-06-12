import 'package:equatable/equatable.dart';

abstract class ContactBlocEvent extends Equatable {
  ContactBlocEvent([List props = const []]) : super(props);
}

class ContactBlocEventLoad extends ContactBlocEvent {
  final String id;

  ContactBlocEventLoad(this.id) : super([id]);
}