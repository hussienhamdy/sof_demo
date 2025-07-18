import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

class GetBookmarkedUsersIdsUsecase {
  final UsersRepository _usersRepository;

  GetBookmarkedUsersIdsUsecase(this._usersRepository);

  Future<Either<Set<int>>> call() async {
    return await _usersRepository.getBookmarkedUsersIds();
  }
}
