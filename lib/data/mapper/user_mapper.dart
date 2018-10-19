import 'package:f_contacter/data/entity/status.dart';
import 'package:f_contacter/data/entity/user.dart';
import 'package:f_contacter/data/network/response/auth_response.dart';

User toUser(AuthResponse response) {
  var id = response.user.id ?? 0;
  var firstName = response.user.firstName ?? '';
  var lastName = response.user.lastName ?? '';
  var fullName = firstName + ' ' + lastName;
  var company = response.user.company.name ?? '';
  var companyId = response.user.company.id ?? 0;
  var email = response.user.email ?? '';
  var image = response.user.avatar ?? '';
  var status = 'Why not prompt $firstName to update their status?';
  return User(id, firstName, lastName, fullName, '', '', email, '', company, companyId, image, Status(id, status, null, null));
}
