import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/features/users/domain/entities/get_user_reputation_state.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/domain/providers.dart';
import 'package:sof_demo/features/users/presentation/providers/notifiers/change_user_bookmark_status_notifier.dart';
import 'package:sof_demo/features/users/presentation/providers/notifiers/get_bookmarked_users_ids_notifier.dart';
import 'package:sof_demo/features/users/presentation/providers/notifiers/get_user_reputations_notifier.dart';
import 'package:sof_demo/features/users/presentation/providers/notifiers/get_users_by_ids_notifier.dart';
import 'package:sof_demo/features/users/presentation/providers/notifiers/get_users_notifier.dart';

final getUsersStateNotifierProvider =
    StateNotifierProvider.autoDispose<
      GetUsersNotifier,
      AsyncValue<GetUsersState>
    >((ref) => GetUsersNotifier(ref.watch(getUsersUsecaseProvider)));

final changeUserBookmarkStatusStateNotifierProvider =
    StateNotifierProvider.autoDispose<
      ChangeUserBookmarkStatusNotifier,
      AsyncValue<bool>
    >(
      (ref) => ChangeUserBookmarkStatusNotifier(
        ref.watch(changeUserBookmarkStatusUsecase),
      ),
    );

final getBookmarkedUsersIdsStatusStateNotifierProvider =
    StateNotifierProvider.autoDispose<
      GetBookmarkedUsersIdsNotifier,
      AsyncValue<Set<int>>
    >(
      (ref) => GetBookmarkedUsersIdsNotifier(
        ref.watch(getBookmarkedUsersIdsUsecase),
      ),
    );

final getBookmarkedUsersStatusStateNotifierProvider =
    StateNotifierProvider.autoDispose<
      GetUsersByIdsNotifier,
      AsyncValue<GetUsersState>
    >((ref) => GetUsersByIdsNotifier(ref.watch(getBookmarkedUsersUsecase)));

final getUserReputationsStateNotifierProvider =
    StateNotifierProvider.autoDispose<
      GetUserReputationNotifier,
      AsyncValue<GetUserReputationState>
    >((ref) => GetUserReputationNotifier(ref.watch(getUserReputationUsecase)));
