import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/features/users/domain/entities/get_user_reputation_state.dart';
import 'package:sof_demo/features/users/domain/entities/user_reputation.dart';
import 'package:sof_demo/features/users/domain/usecases/get_user_reputation_usecase.dart';

class GetUserReputationNotifier
    extends StateNotifier<AsyncValue<GetUserReputationState>> {
  final GetUserReputationUsecase _getUserReputationUsecase;

  GetUserReputationNotifier(this._getUserReputationUsecase)
    : super(const AsyncValue.loading());

  Future<void> getUserReputations(int userId, {int pageSize = 20}) async {
    state = const AsyncValue.loading();
    final response = await _getUserReputationUsecase.call(1, pageSize, userId);
    if (response.getResult() is Failure) {
      state = AsyncValue.error(response.getResult(), StackTrace.empty);
    } else {
      state = AsyncValue.data(response.getResult());
    }
  }

  Future<void> getMoreUserReputations(int userId, [int pageSize = 20]) async {
    List<UserReputation> oldList = state.value?.reputations ?? [];
    int oldPage = state.value?.page ?? 0;
    final response = await _getUserReputationUsecase.call(
      (state.value?.page ?? 0) + 1,
      pageSize,
      userId,
    );
    if (response.getResult() is Failure) {
      GetUserReputationState(
        reputations: oldList,
        hasMoreData: false,
        page: oldPage,
      );
    } else {
      List<UserReputation> newList = List.from(oldList)
        ..addAll((response.getResult() as GetUserReputationState).reputations);
      state = AsyncValue.data(
        GetUserReputationState(
          reputations: newList,
          hasMoreData:
              (response.getResult() as GetUserReputationState).hasMoreData,
          page: (response.getResult() as GetUserReputationState).page,
        ),
      );
    }
  }
}
