import 'package:bloc/bloc.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/data/repository/status_repository.dart';
import 'package:f_contacter/data/repository/users_repository.dart';
import 'package:f_contacter/entity/status.dart';
import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/bloc/contacts/contacts_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/contacts/contacts_bloc_state.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_items.dart';
import 'package:f_contacter/res/strings.dart';

class ContactsBloc extends Bloc<ContactsBlocEvent, ContactsBlocState> {
  UsersRepository _usersRepository = UsersRepository();
  ProfileRepository _profileRepository = ProfileRepository();
  StatusRepository _statusRepository = StatusRepository();
  List<User> users;
  List<ContactsListItem> contacts;

  @override
  ContactsBlocState get initialState => ContactsBlocStateLoading();

  @override
  Stream<ContactsBlocState> mapEventToState(ContactsBlocEvent event) {
    if (event is ContactsBlocEventLoad) {
      return _loadContacts();
    } else if (event is ContactsBlocEventFilter) {
      return _filterContacts(event.query);
    }
  }

  Stream<ContactsBlocState> _loadContacts() async* {
    try {
      var localUser = await _profileRepository.getProfileLocal();
      var companyId = int.parse(localUser.companyId);
      var users = await _usersRepository.getUsersFromNetwork(companyId);
      var statuses = await _statusRepository.getUsersStatusesFromNetwork();
      //add statuses
      users = _getUsersWithStatuses(users, statuses);
      //sort by name
      users.sort((a, b) => a.fullName.compareTo(b.fullName));
      this.users = users;
      //remove current user
      var currentUser = users.firstWhere((user) => user.id == localUser.id, orElse: () {});
      users.remove(currentUser);
      //result
      contacts = _getContactsItemsList(_getWelcome(currentUser.name), _getWish(currentUser.company), users, currentUser);
      yield ContactsBlocStateSuccess(contacts);
    } catch (error) {
      yield ContactsBlocStateError(error);
    }
  }

  Stream<ContactsBlocState> _filterContacts(String query) async* {
    try {
      if (query.isEmpty) {
        yield ContactsBlocStateSuccess(contacts);
      } else {
        var filteredContacts = List<ContactsListItem>();
        users.forEach((user) {
          if (user.fullName.contains(query)) {
            filteredContacts.add(ContactsItem(user));
          }
        });
        yield ContactsBlocStateSuccess(filteredContacts);
      }
    } catch (error) {
//        yield ContactsBlocStateError(error);
    }
  }

  List<User> _getUsersWithStatuses(List<User> users, List<Status> statuses) {
    var result = List<User>();
    users.forEach((user) {
      var status = statuses.firstWhere((status) => status.ownerId == user.id, orElse: () => null);
      user.status = status ?? _getDefaultStatus(user);
      result.add(user);
    });
    return result;
  }

  Status _getDefaultStatus(User user) => Status(
      user.id,
      AppStrings.newsDefaultStatus(user.name),
      "2000-01-01T00:00:00Z",
      AppStrings.newsUpdateLongTimeAgo
  );

  String _getWelcome(String name) => AppStrings.contactsHeaderTitle(name);

  String _getWish(String companyName) => AppStrings.contactsHeaderDescription(companyName);

  List<ContactsListItem> _getContactsItemsList(String title, String subTitle, List<User> users, User currentUser) {
    var items = List<ContactsListItem>();
    items.add(ContactsTopHeader(title, subTitle));
    items.add(ContactsItem(currentUser));
    for (int i = 0; i < users.length; i++) {
      if (i == 0) {
        items.add(ContactsHeader(users[i].name[0]));
        items.add(ContactsItem(users[i]));
      } else {
        if (users[i].name[0] == users[i-1].name[0]) {
          items.add(ContactsItem(users[i]));
        } else {
          items.add(ContactsHeader(users[i].name[0]));
          items.add(ContactsItem(users[i]));
        }
      }
    }
    return items;
  }
}