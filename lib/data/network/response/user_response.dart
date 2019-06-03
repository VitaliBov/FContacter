class UserResponse {
  String status;
  UserModelResponse user;

  UserResponse._({this.status, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse._(
        status: json['STATUS'],
        user: json['user']
    );
  }
}

class UserModelResponse {
  int id;
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