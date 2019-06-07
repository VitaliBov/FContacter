import 'package:f_contacter/entity/status.dart';

class User {
  String id;
  String name;
  String lastName;
  String fullName;
  String initials;
  String phone;
  String email;
  String position;
  String company;
  String companyId;
  String image;
  Status status;

  User.empty();

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

  User.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        name = json['name'],
        lastName = json['lastName'],
        fullName = json['fullName'],
        initials = json['initials'],
        phone = json['phone'],
        email = json['email'],
        position = json['position'],
        company = json['company'],
        companyId = json['companyId'],
        image = json['image'],
        status = Status.fromJson(json['status']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'fullName': fullName,
        'initials': initials,
        'phone': phone,
        'email': email,
        'position': position,
        'company': company,
        'companyId': companyId,
        'image': image,
        'status': status.toJson()
      };
}
