import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

class ChangeUserBookmarkStatusUsecase {
  final UsersRepository _usersRepository;

  ChangeUserBookmarkStatusUsecase(this._usersRepository);

  Future<Either<bool>> call(int userId, bool isbookmarked) async {
    if (isbookmarked) {
      return await _usersRepository.debookmarkUser(userId);
    } else {
      return await _usersRepository.bookmarkUser(userId);
    }
  }
}
