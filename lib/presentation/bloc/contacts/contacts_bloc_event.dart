import 'package:equatable/equatable.dart';

abstract class ContactsBlocEvent extends Equatable {
  ContactsBlocEvent([List props = const []]) : super(props);
}

class ContactsBlocEventLoad extends ContactsBlocEvent {
  ContactsBlocEventLoad() : super();
}