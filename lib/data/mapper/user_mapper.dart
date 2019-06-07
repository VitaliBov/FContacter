import 'package:f_contacter/data/network/response/auth_response.dart';
import 'package:f_contacter/data/network/response/users_response.dart';
import 'package:f_contacter/entity/status.dart';
import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/res/strings.dart';

List<User> usersResponseToUsers(UsersResponse response) {
  List<User> list = List();
  response.users.map((userResponse) =>
      list.add(userModelResponseToUser(userResponse))
  );
  return list;
}

User userResponseToUser(UserResponse response) {
  return userModelResponseToUser(response.user);
}

User userModelResponseToUser(UserModelResponse response) {
  var id = response.id ?? 0;
  var firstName = response.firstName ?? '';
  var lastName = response.lastName ?? '';
  var fullName = '';
  if (firstName != null && lastName != null) {
    fullName = firstName + ' ' + lastName;
  }
  var initials = '';
  if (firstName != null && lastName != null) {
    initials = firstName + ' ' + lastName[0];
  }
  var position = response.title ?? '';
  var company = response.companyName ?? '';
  var companyId = response.companyId ?? 0;
  var phone = response.phoneNumberMobile ?? '';
  var email = response.emailAddress ?? '';
  var image = response.avatarUrl ?? '';
  var status = AppStrings.defaultStatus(firstName);
  return User(id, firstName, lastName, fullName, initials, phone, email, position, company, companyId, image, Status(id, status, null, null));
}

User authResponseToUser(AuthResponse response) {
  var id = response.user.id ?? 0;
  var firstName = response.user.firstName ?? '';
  var lastName = response.user.lastName ?? '';
  var fullName = '';
  if (firstName != null && lastName != null) {
    fullName = firstName + ' ' + lastName;
  }
  var initials = '';
  if (firstName != null && lastName != null) {
    initials = firstName + ' ' + lastName[0];
  }
  var company = response.user.company.name ?? '';
  var companyId = response.user.company.id ?? 0;
  var email = response.user.email ?? '';
  var image = response.user.avatar ?? '';
  var status = AppStrings.defaultStatus(firstName);
  return User(id, firstName, lastName, fullName, initials, 'phone', email, 'position', company, companyId, image, Status(id, status, null, null));
}