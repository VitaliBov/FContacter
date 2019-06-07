import 'package:f_contacter/data/mapper/user_mapper.dart';
import 'package:f_contacter/data/network/api_client.dart';
import 'package:f_contacter/entity/user.dart';

class UsersRepository {
  static final _usersRepository = UsersRepository._internal();
  final ApiClient _apiClient = ApiClient();

  UsersRepository._internal();
  factory UsersRepository() => _usersRepository;

  Future<List<User>> getUsersFromNetwork(int companyId) async => usersResponseToUsers(await _apiClient.gerUsers(companyId));
  Future<User> getUserFromNetwork(int id) async => userResponseToUser(await _apiClient.gerUser(id));
}