import 'package:f_contacter/data/entity/status.dart';

class User {
  int id;
  String name;
  String lastName;
  String fullName;
  String initials;
  String phone;
  String email;
  String position;
  String company;
  int companyId;
  String image;
  Status status;

  User(
      this.id,
      this.name,
      this.lastName,
      this.fullName,
      this.initials,
      this.phone,
      this.email,
      this.position,
      this.company,
      this.companyId,
      this.image,
      this.status);
}
