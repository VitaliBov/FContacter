import 'package:f_contacter/data/network/response/status_response.dart';
import 'package:f_contacter/entity/status.dart';
import 'package:f_contacter/res/strings.dart';

List<Status> statusesResponseToStatuses(StatusesResponse response) {
  List<Status> list = List();
  response.userStatuses.forEach((statusResponse) =>
      list.add(statusBodyToStatus(statusResponse))
  );
  return list;
}

Status statusResponseToStatus(StatusResponse response, {String name = ''}) {
  return statusBodyToStatus(response.userStatus, name: name);
}

Status statusBodyToStatus(StatusBody response, {String name = '-'}) {
  var ownerId = response.userId ?? '0';
  var status = response.status ?? AppStrings.defaultStatus(name);
  var dateOfChange = response.lastChangedOn ?? "2000-01-01T00:00:00Z";
  //TODO parse date
  var dateOfChangeTitle = AppStrings.newsUpdateLongTimeAgo;
  return Status(ownerId, status, dateOfChange, dateOfChangeTitle);
}