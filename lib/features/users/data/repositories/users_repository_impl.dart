import 'package:flutter/foundation.dart';
import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/core/enums.dart';
import 'package:sof_demo/core/exceptions.dart';
import 'package:sof_demo/core/extensions.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/features/users/data/datasource/users_local_datasource.dart';
import 'package:sof_demo/features/users/data/datasource/users_remote_datasource.dart';
import 'package:sof_demo/features/users/domain/entities/badge_count.dart';
import 'package:sof_demo/features/users/domain/entities/get_user_reputation_state.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/domain/entities/user.dart';
import 'package:sof_demo/features/users/domain/entities/user_reputation.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDatasource _usersRemoteDatasource;
  final UsersLocalDatasource _usersLocalDatasource;
  UsersRepositoryImpl(this._usersRemoteDatasource, this._usersLocalDatasource);

  @override
  Future<Either<GetUsersState>> getUsers(int page, int pageSize) async {
    try {
      final result = await _usersRemoteDatasource.getUsers(page, pageSize);
      final List<User> list = result.users
          .map(
            (element) => User(
              userId: element.userId,
              profileImage: element.profileImage,
              displayName: element.displayName,
              badgeCount: BadgeCount(
                bronzeCount: element.badgeCount.bronzeCount,
                silverCount: element.badgeCount.silverCount,
                goldCount: element.badgeCount.goldCount,
              ),
            ),
          )
          .toList();
      return Either(
        value: GetUsersState(
          users: list,
          hasMoreData: result.hasMoreData,
          page: page,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint("$stackTrace");
      if (error is NetworkException) {
        return Either(failure: NetworkFailure());
      } else if (error is ExceptionWithMessage) {
        return Either(failure: FailureWithMessage(message: error.message));
      } else {
        return Either(failure: GeneralFailure());
      }
    }
  }

  @override
  Future<Either<bool>> bookmarkUser(int userId) async {
    try {
      await _usersLocalDatasource.bookmarkUser(userId);
      return Either(value: true);
    } catch (error, stackTrace) {
      debugPrint("$stackTrace");
      if (error is NetworkException) {
        return Either(failure: NetworkFailure());
      } else if (error is ExceptionWithMessage) {
        return Either(failure: FailureWithMessage(message: error.message));
      } else {
        return Either(failure: GeneralFailure());
      }
    }
  }

  @override
  Future<Either<bool>> debookmarkUser(int userId) async {
    try {
      await _usersLocalDatasource.debookmarkUser(userId);
      return Either(value: true);
    } catch (error, stackTrace) {
      debugPrint("$stackTrace");
      if (error is NetworkException) {
        return Either(failure: NetworkFailure());
      } else if (error is ExceptionWithMessage) {
        return Either(failure: FailureWithMessage(message: error.message));
      } else {
        return Either(failure: GeneralFailure());
      }
    }
  }

  @override
  Future<Either<Set<int>>> getBookmarkedUsersIds() async {
    try {
      final Set<int> bookmarkedUserIds = await _usersLocalDatasource
          .getAllBookmarkedUserIds();
      return Either(value: bookmarkedUserIds);
    } catch (error, stackTrace) {
      debugPrint("$stackTrace");
      if (error is NetworkException) {
        return Either(failure: NetworkFailure());
      } else if (error is ExceptionWithMessage) {
        return Either(failure: FailureWithMessage(message: error.message));
      } else {
        return Either(failure: GeneralFailure());
      }
    }
  }

  @override
  Future<Either<GetUsersState>> getUsersByIds(
    int page,
    int pageSize,
    List<int> usersIds,
  ) async {
    try {
      final result = await _usersRemoteDatasource.getUsersByIds(
        page,
        pageSize,
        usersIds,
      );
      final List<User> list = result.users
          .map(
            (element) => User(
              userId: element.userId,
              profileImage: element.profileImage,
              displayName: element.displayName,
              badgeCount: BadgeCount(
                bronzeCount: element.badgeCount.bronzeCount,
                silverCount: element.badgeCount.silverCount,
                goldCount: element.badgeCount.goldCount,
              ),
            ),
          )
          .toList();
      return Either(
        value: GetUsersState(
          users: list,
          hasMoreData: result.hasMoreData,
          page: page,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint("$stackTrace");
      if (error is NetworkException) {
        return Either(failure: NetworkFailure());
      } else if (error is ExceptionWithMessage) {
        return Either(failure: FailureWithMessage(message: error.message));
      } else {
        return Either(failure: GeneralFailure());
      }
    }
  }

  @override
  Future<Either<GetUserReputationState>> getUserReputations(
    int page,
    int pageSize,
    int userId,
  ) async {
    try {
      final result = await _usersRemoteDatasource.getUserReputations(
        page,
        pageSize,
        userId,
      );
      final List<UserReputation> list = result.reputations.map((element) {
        return UserReputation(
          userId: element.userId,
          postId: element.postId,
          reputationHistoryType:
              EnumHandler.enumFromString(
                ReputationHistoryType.values,
                element.reputationHistoryType,
              ) ??
              ReputationHistoryType.post_upvoted,
          creationDate: element.creationDate.dateTime,
          reputationChange: element.reputationChange,
        );
      }).toList();
      return Either(
        value: GetUserReputationState(
          reputations: list,
          hasMoreData: result.hasMoreData,
          page: page,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint("$stackTrace");
      if (error is NetworkException) {
        return Either(failure: NetworkFailure());
      } else if (error is ExceptionWithMessage) {
        return Either(failure: FailureWithMessage(message: error.message));
      } else {
        return Either(failure: GeneralFailure());
      }
    }
  }
}
