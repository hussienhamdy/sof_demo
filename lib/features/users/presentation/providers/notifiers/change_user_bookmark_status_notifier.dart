import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/features/users/domain/usecases/change_user_bookmark_status_usecase.dart';

class ChangeUserBookmarkStatusNotifier extends StateNotifier<AsyncValue<bool>> {
  final ChangeUserBookmarkStatusUsecase _changeUserBookmarkStatusUsecase;

  ChangeUserBookmarkStatusNotifier(this._changeUserBookmarkStatusUsecase)
    : super(const AsyncValue.loading());

  Future<void> changeUserBookmarkStatus(int userId, bool isbookmarked) async {
    state = const AsyncValue.loading();
    final response = await _changeUserBookmarkStatusUsecase.call(
      userId,
      isbookmarked,
    );
    if (response.getResult() is Failure) {
      state = AsyncValue.error(response.getResult(), StackTrace.empty);
    } else {
      state = AsyncValue.data(response.getResult());
    }
  }
}
