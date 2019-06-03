import 'package:f_contacter/data/network/response/auth_response.dart';
import 'package:f_contacter/data/network/response/user_response.dart';
import 'package:f_contacter/entity/status.dart';
import 'package:f_contacter/entity/user.dart';

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
  var status = 'Why not prompt $firstName to update their status?';
  return User(id, firstName, lastName, fullName, initials, 'phone', email, 'position', company, companyId, image, Status(id, status, null, null));
}

User userResponseToUser(UserModelResponse response) {
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
  var status = 'Why not prompt $firstName to update their status?';
  return User(id, firstName, lastName, fullName, initials, phone, email, position, company, companyId, image, Status(id, status, null, null));
}
