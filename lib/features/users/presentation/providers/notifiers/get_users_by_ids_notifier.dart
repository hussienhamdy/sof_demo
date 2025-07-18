import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/domain/entities/user.dart';
import 'package:sof_demo/features/users/domain/usecases/get_users_by_ids_usecase.dart';

class GetUsersByIdsNotifier extends StateNotifier<AsyncValue<GetUsersState>> {
  final GetUsersByIdsUsecase _getUsersByIdsUsecase;

  GetUsersByIdsNotifier(this._getUsersByIdsUsecase)
    : super(const AsyncValue.loading());

  Future<void> getUsersByIds(List<int> usersIds, {int pageSize = 20}) async {
    if (usersIds.isEmpty) {
      state = AsyncValue.data(
        GetUsersState(users: [], page: 1, hasMoreData: false),
      );
    } else {
      state = const AsyncValue.loading();
      final response = await _getUsersByIdsUsecase.call(1, pageSize, usersIds);
      if (response.getResult() is Failure) {
        state = AsyncValue.error(response.getResult(), StackTrace.empty);
      } else {
        state = AsyncValue.data(response.getResult());
      }
    }
  }

  Future<void> updateList(List<int> usersIds) async {
    List<User> oldList = state.value?.users ?? [];
    int oldPage = state.value?.page ?? 0;
    bool hasMoreData = state.value?.hasMoreData ?? false;
    List<User> newList = [];
    for (User user in oldList) {
      if (usersIds.contains(user.userId)) {
        newList.add(user);
      }
    }
    state = AsyncValue.data(
      GetUsersState(users: newList, hasMoreData: hasMoreData, page: oldPage),
    );
  }

  Future<void> getMoreUsers(List<int> usersIds, [int pageSize = 20]) async {
    List<User> oldList = state.value?.users ?? [];
    int oldPage = state.value?.page ?? 0;
    final response = await _getUsersByIdsUsecase.call(
      (state.value?.page ?? 0) + 1,
      pageSize,
      usersIds,
    );
    if (response.getResult() is Failure) {
      GetUsersState(users: oldList, hasMoreData: false, page: oldPage);
    } else {
      List<User> newList = List.from(oldList)
        ..addAll((response.getResult() as GetUsersState).users);
      state = AsyncValue.data(
        GetUsersState(
          users: newList,
          hasMoreData: (response.getResult() as GetUsersState).hasMoreData,
          page: (response.getResult() as GetUsersState).page,
        ),
      );
    }
  }
}
