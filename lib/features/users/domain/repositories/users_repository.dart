import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/features/users/domain/entities/get_user_reputation_state.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';

abstract class UsersRepository {
  Future<Either<GetUsersState>> getUsers(int page, int pageSize);
  Future<Either<bool>> bookmarkUser(int userId);
  Future<Either<bool>> debookmarkUser(int userId);
  Future<Either<Set<int>>> getBookmarkedUsersIds();
  Future<Either<GetUsersState>> getUsersByIds(
    int page,
    int pageSize,
    List<int> usersIds,
  );

  Future<Either<GetUserReputationState>> getUserReputations(
    int page,
    int pageSize,
    int userId,
  );
}
