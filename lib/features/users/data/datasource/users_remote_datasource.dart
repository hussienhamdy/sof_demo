import 'package:flutter/foundation.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/core/services/api_service.dart';
import 'package:sof_demo/core/url_generator.dart';
import 'package:sof_demo/features/users/data/models/get_user_reputation_state_model.dart';
import 'package:sof_demo/features/users/data/models/get_users_state_model.dart';
import 'package:sof_demo/features/users/data/models/user_model.dart';
import 'package:sof_demo/features/users/data/models/user_reputation_model.dart';

abstract class UsersRemoteDatasource {
  Future<GetUsersStateModel> getUsers(int page, int pageSize);
  Future<GetUsersStateModel> getUsersByIds(
    int page,
    int pageSize,
    List<int> usersIds,
  );

  Future<GetUserReputationStateModel> getUserReputations(
    int page,
    int pageSize,
    int userId,
  );
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource {
  final ApiService _apiService;
  UsersRemoteDatasourceImpl(this._apiService);
  @override
  Future<GetUsersStateModel> getUsers(int page, int pageSize) async {
    var url = URLGenerator.getUsersPath(page, pageSize);
    try {
      List<UserModel> list = [];
      final response = await _apiService.get(uri: url);
      for (var element in response['items']) {
        list.add(UserModel.fromJson(element));
      }

      return GetUsersStateModel(users: list, hasMoreData: response['has_more']);
    } catch (error, stackTrace) {
      debugPrint('getUsers $error, $stackTrace');
      rethrow;
    }
  }

  @override
  Future<GetUsersStateModel> getUsersByIds(
    int page,
    int pageSize,
    List<int> usersIds,
  ) async {
    var url = URLGenerator.getUsersByIdsPath(page, pageSize, usersIds);
    try {
      List<UserModel> list = [];
      final response = await _apiService.get(uri: url);
      for (var element in response['items']) {
        list.add(UserModel.fromJson(element));
      }
      return GetUsersStateModel(users: list, hasMoreData: response['has_more']);
    } catch (error, stackTrace) {
      debugPrint('getUsersByIds $error, $stackTrace');
      rethrow;
    }
  }

  @override
  Future<GetUserReputationStateModel> getUserReputations(
    int page,
    int pageSize,
    int userId,
  ) async {
    var url = URLGenerator.getUserReputationPath(page, pageSize, userId);
    try {
      List<UserReputationModel> list = [];
      final response = await _apiService.get(uri: url);
      if (response['items'] == null) {
        throw GeneralFailure();
      }
      for (var element in response['items']) {
        list.add(UserReputationModel.fromJson(element));
      }
      return GetUserReputationStateModel(
        reputations: list,
        hasMoreData: response['has_more'],
      );
    } catch (error, stackTrace) {
      debugPrint('getUserReputations $error, $stackTrace');
      rethrow;
    }
  }
}
