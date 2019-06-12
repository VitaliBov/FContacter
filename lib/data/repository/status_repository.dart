import 'package:f_contacter/data/mapper/status_mapper.dart';
import 'package:f_contacter/data/network/api_client.dart';
import 'package:f_contacter/data/network/request/status_request.dart';
import 'package:f_contacter/entity/status.dart';

class StatusRepository {
  static final _statusRepository = StatusRepository._internal();
  final ApiClient _apiClient = ApiClient();

  StatusRepository._internal();
  factory StatusRepository() => _statusRepository;

  Future<List<Status>> getUsersStatusesFromNetwork() async => statusesResponseToStatuses(await _apiClient.gerStatuses());
  Future<Status> getUserStatusFromNetwork(int userId, String name) async => statusResponseToStatus(await _apiClient.gerStatus(userId), name: name);
  Future<Status> getCurrentUserStatusFromNetwork() async => statusResponseToStatus(await _apiClient.gerCurrentUserStatus());
  Future<bool> createCurrentUserStatus(StatusRequest request) async => (await _apiClient.createCurrentUserStatus(request)).statusMessage == 'OK';
}