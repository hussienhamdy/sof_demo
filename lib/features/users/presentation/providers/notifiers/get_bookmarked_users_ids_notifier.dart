import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/features/users/domain/usecases/get_bookmarked_users_ids_usecase.dart';

class GetBookmarkedUsersIdsNotifier
    extends StateNotifier<AsyncValue<Set<int>>> {
  final GetBookmarkedUsersIdsUsecase _getBookmarkedUsersIdsUsecase;

  GetBookmarkedUsersIdsNotifier(this._getBookmarkedUsersIdsUsecase)
    : super(const AsyncValue.loading());

  Future<void> getBookmarkedUsersIds() async {
    state = const AsyncValue.loading();
    final response = await _getBookmarkedUsersIdsUsecase.call();

    if (response.getResult() is Failure) {
      state = AsyncValue.error(response.getResult(), StackTrace.empty);
    } else {
      state = AsyncValue.data(response.getResult());
    }
  }
}
