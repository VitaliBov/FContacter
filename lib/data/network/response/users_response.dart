import 'package:f_contacter/data/network/response/base_response.dart';

class UsersResponse extends BaseResponse {
  List<UserModelResponse> users;

  UsersResponse._({
    this.users
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    var response = UsersResponse._(
        users: json['people'].map<UserModelResponse>((json) => UserModelResponse.fromJson(json)).toList()
    );
    response.statusMessage = json['STATUS'];
    return response;
  }
}


class UserResponse extends BaseResponse {
  UserModelResponse user;

  UserResponse._({
    this.user
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    var response = UserResponse._(
        user: UserModelResponse.fromJson(json['person'])
    );
    response.statusMessage = json['STATUS'];
    return response;
  }
}

class UserModelResponse {
  String id;
  String firstName;
  String lastName;
  String phoneNumberMobile;
  String emailAddress;
  String companyName;
  String companyId;
  String title;
  String avatarUrl;

  UserModelResponse._({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumberMobile,
    this.emailAddress,
    this.companyName,
    this.companyId,
    this.title,
    this.avatarUrl
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) {
    return UserModelResponse._(
      id: json['id'],
      firstName: json['first-name'],
      lastName: json['last-name'],
      phoneNumberMobile: json['phone-number-mobile'],
      emailAddress: json['email-address'],
      companyName: json['company-name'],
      companyId: json['companyId'],
      title: json['title'],
      avatarUrl: json['avatar-url'],
    );
  }
}