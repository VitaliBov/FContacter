class AuthResponse {
  String accessToken;
  Installation installation;
  String status;
  AuthUser user;

  AuthResponse._({this.accessToken, this.installation, this.status, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse._(
        accessToken: json['access_token'],
        installation: Installation.fromJson(json['installation']),
        status: json['status'],
        user: AuthUser.fromJson(json['user'])
    );
  }
}

class Installation {
  int id;
  String name;
  String region;
  String apiEndPoint;
  String url;
  bool chatEnabled;
  AuthCompany company;
  String logo;

  Installation._({this.id, this.name, this.region, this.apiEndPoint, this.url,
      this.chatEnabled, this.company, this.logo});

  factory Installation.fromJson(Map<String, dynamic> json) {
    return Installation._(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        apiEndPoint: json["apiEndPoint"],
        url: json["url"],
        chatEnabled: json["chatEnabled"],
        company: AuthCompany.fromJson(json["company"]),
        logo: json["logo"]
    );
  }
}

class AuthCompany {
  int id;
  String name;
  String logo;

  AuthCompany._({this.id, this.name, this.logo});

  factory AuthCompany.fromJson(Map<String, dynamic> json) {
    return AuthCompany._(
        id: json['id'],
        name: json['name'],
        logo: json['logo']
    );
  }
}

class AuthUser {
  int id;
  String firstName;
  String lastName;
  String email;
  String avatar;
  AuthCompany company;

  AuthUser._({this.id, this.firstName, this.lastName, this.email, this.avatar,
      this.company});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser._(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        avatar: json['avatar'],
        company: AuthCompany.fromJson(json['company'])
    );
  }
}
