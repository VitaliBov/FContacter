class StatusRequest {
  String status;
  String notify = "no";

  StatusRequest(this.status);

  Map toJson() {
    return {
      "userstatus": {
        "status": "$status",
        "notify": "$notify"
      }
    };
  }
}