import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/features/users/data/providers.dart';
import 'package:sof_demo/features/users/domain/usecases/change_user_bookmark_status_usecase.dart';
import 'package:sof_demo/features/users/domain/usecases/get_bookmarked_users_ids_usecase.dart';
import 'package:sof_demo/features/users/domain/usecases/get_user_reputation_usecase.dart';
import 'package:sof_demo/features/users/domain/usecases/get_users_by_ids_usecase.dart';
import 'package:sof_demo/features/users/domain/usecases/get_users_usecase.dart';

final getUsersUsecaseProvider = Provider<GetUsersUsecase>(
  (ref) => GetUsersUsecase(ref.watch(usersRepositoryProvider)),
);

final changeUserBookmarkStatusUsecase =
    Provider<ChangeUserBookmarkStatusUsecase>(
      (ref) =>
          ChangeUserBookmarkStatusUsecase(ref.watch(usersRepositoryProvider)),
    );

final getBookmarkedUsersIdsUsecase = Provider<GetBookmarkedUsersIdsUsecase>(
  (ref) => GetBookmarkedUsersIdsUsecase(ref.watch(usersRepositoryProvider)),
);

final getBookmarkedUsersUsecase = Provider<GetUsersByIdsUsecase>(
  (ref) => GetUsersByIdsUsecase(ref.watch(usersRepositoryProvider)),
);

final getUserReputationUsecase = Provider<GetUserReputationUsecase>(
  (ref) => GetUserReputationUsecase(ref.watch(usersRepositoryProvider)),
);
