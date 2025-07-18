import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

class GetUsersUsecase {
  final UsersRepository _usersRepository;

  GetUsersUsecase(this._usersRepository);

  Future<Either<GetUsersState>> call(int page, int pageSize) async {
    return await _usersRepository.getUsers(page, pageSize);
  }
}
