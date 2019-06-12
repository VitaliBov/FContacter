import 'package:f_contacter/entity/user.dart';

abstract class ContactsListItem {
  final String title;

  ContactsListItem(this.title);
}

class ContactsTopHeader implements ContactsListItem {
  @override
  final String title;
  final String subTitle;

  ContactsTopHeader(this.title, this.subTitle);
}

class ContactsHeader implements ContactsListItem {
  @override
  final String title;

  ContactsHeader(this.title);
}

class ContactsItem implements ContactsListItem {
  @override
  final String title;
  final User user;

  ContactsItem(this.user) : title = user.initials;
}