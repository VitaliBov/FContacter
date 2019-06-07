class BaseResponse {
  String statusMessage = "OK";

  BaseResponse();

  BaseResponse._({this.statusMessage});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse._(
        statusMessage: json['STATUS']
    );
  }
}