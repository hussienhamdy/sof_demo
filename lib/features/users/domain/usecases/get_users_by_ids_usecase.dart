import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

class GetUsersByIdsUsecase {
  final UsersRepository _usersRepository;

  GetUsersByIdsUsecase(this._usersRepository);

  Future<Either<GetUsersState>> call(
    int page,
    int pageSize,
    List<int> usersIds,
  ) async {
    return await _usersRepository.getUsersByIds(page, pageSize, usersIds);
  }
}
