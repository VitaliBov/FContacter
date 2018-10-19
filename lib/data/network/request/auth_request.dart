class AuthRequest {
  String code;

  AuthRequest(this.code);

  Map toJson() {
    return {"code": "$code"};
  }
}
