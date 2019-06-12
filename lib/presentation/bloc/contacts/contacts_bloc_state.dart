import 'package:equatable/equatable.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_items.dart';

class ContactsBlocState extends Equatable {
  ContactsBlocState([List props = const []]) : super(props);
}

class ContactsBlocStateLoading extends ContactsBlocState {}

class ContactsBlocStateSuccess extends ContactsBlocState {
  final List<ContactsListItem> contacts;

  ContactsBlocStateSuccess(this.contacts) : super([contacts]);
}

class ContactsBlocStateError extends ContactsBlocState {
  Exception exception;

  ContactsBlocStateError(this.exception) : super([exception]);
}