import 'package:sof_demo/core/either.dart';
import 'package:sof_demo/features/users/domain/entities/get_user_reputation_state.dart';
import 'package:sof_demo/features/users/domain/repositories/users_repository.dart';

class GetUserReputationUsecase {
  final UsersRepository _usersRepository;

  GetUserReputationUsecase(this._usersRepository);

  Future<Either<GetUserReputationState>> call(
    int page,
    int pageSize,
    int userId,
  ) async {
    return await _usersRepository.getUserReputations(page, pageSize, userId);
  }
}
