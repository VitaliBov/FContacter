import 'package:f_contacter/data/network/response/base_response.dart';

class StatusesResponse extends BaseResponse {
  List<StatusBody> userStatuses;

  StatusesResponse._({this.userStatuses});

  factory StatusesResponse.fromJson(Map<String, dynamic> json) {
    var response = StatusesResponse._(
        userStatuses: json['userStatuses'].map<StatusBody>((json) => StatusBody.fromJson(json)).toList()
    );
    response.statusMessage = json['STATUS'];
    return response;
  }
}

class StatusResponse extends BaseResponse {
  StatusBody userStatus;

  StatusResponse._({this.userStatus});

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    var response = StatusResponse._(
        userStatus: StatusBody.fromJson(json['userStatus'])
    );
    response.statusMessage = json['STATUS'];
    return response;
  }
}

class StatusBody {
  String geoipLocation;
  String postedOn;
  String firstName;
  String avatarUrl;
  String id;
  String lastChangedOn;
  String status;
  String lastName;
  String userId;

  StatusBody._({
    this.geoipLocation,
    this.postedOn,
    this.firstName,
    this.avatarUrl,
    this.id,
    this.lastChangedOn,
    this.status,
    this.lastName,
    this.userId
  });

  factory StatusBody.fromJson(Map<String, dynamic> json) {
    return StatusBody._(
        geoipLocation: json['geoipLocation'],
        postedOn: json['posted-on'],
        firstName: json['first-name'],
        avatarUrl: json['avatar-url'],
        id: json['id'],
        lastChangedOn: json['last-changed-on'],
        status: json['status'],
        lastName: json['last-name'],
        userId: json['userId']
    );
  }
}