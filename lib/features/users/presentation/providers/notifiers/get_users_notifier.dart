import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/domain/entities/user.dart';
import 'package:sof_demo/features/users/domain/usecases/get_users_usecase.dart';

class GetUsersNotifier extends StateNotifier<AsyncValue<GetUsersState>> {
  final GetUsersUsecase _getUsersUsecase;

  GetUsersNotifier(this._getUsersUsecase) : super(const AsyncValue.loading());

  Future<void> getUsers({int pageSize = 20}) async {
    state = const AsyncValue.loading();
    final response = await _getUsersUsecase.call(1, pageSize);
    if (response.getResult() is Failure) {
      state = AsyncValue.error(response.getResult(), StackTrace.empty);
    } else {
      state = AsyncValue.data(response.getResult());
    }
  }

  Future<void> getMoreUsers([int pageSize = 20]) async {
    List<User> oldList = state.value?.users ?? [];
    int oldPage = state.value?.page ?? 0;
    final response = await _getUsersUsecase.call(
      (state.value?.page ?? 0) + 1,
      pageSize,
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
