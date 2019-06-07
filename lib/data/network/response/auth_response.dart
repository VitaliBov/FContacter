import 'package:f_contacter/data/network/response/base_response.dart';

class AuthResponse extends BaseResponse {
  String accessToken;
  Installation installation;
  String status;
  AuthUser user;

  AuthResponse._({
    this.accessToken,
    this.installation,
    this.status,
    this.user
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    var response = AuthResponse._(
        accessToken: json['access_token'],
        installation: Installation.fromJson(json['installation']),
        status: json['status'],
        user: AuthUser.fromJson(json['user'])
    );
    response.statusMessage = json['STATUS'];
    return response;
  }
}

class Installation {
  String id;
  String name;
  String region;
  String apiEndPoint;
  String url;
  bool chatEnabled;
  AuthCompany company;
  String logo;

  Installation._({
    this.id,
    this.name,
    this.region,
    this.apiEndPoint,
    this.url,
    this.chatEnabled,
    this.company,
    this.logo
  });

  factory Installation.fromJson(Map<String, dynamic> json) {
    return Installation._(
        id: json['id'].toString(),
        name: json['name'],
        region: json['region'],
        apiEndPoint: json['apiEndPoint'],
        url: json['url'],
        chatEnabled: json['chatEnabled'],
        company: AuthCompany.fromJson(json['company']),
        logo: json['logo']
    );
  }
}

class AuthCompany {
  String id;
  String name;
  String logo;

  AuthCompany._({
    this.id,
    this.name,
    this.logo
  });

  factory AuthCompany.fromJson(Map<String, dynamic> json) {
    return AuthCompany._(
        id: json['id'].toString(),
        name: json['name'],
        logo: json['logo']
    );
  }
}

class AuthUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String avatar;
  AuthCompany company;

  AuthUser._({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.company
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser._(
        id: json['id'].toString(),
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        avatar: json['avatar'],
        company: AuthCompany.fromJson(json['company'])
    );
  }
}