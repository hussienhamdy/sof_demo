import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/presentation/providers/providers.dart';
import 'package:sof_demo/features/users/presentation/widgets/custom_app_bar.dart';
import 'package:sof_demo/features/users/presentation/widgets/pagination_loading.dart';
import 'package:sof_demo/features/users/presentation/widgets/users_list.dart';

class BookmarkedUsersScreen extends ConsumerStatefulWidget {
  const BookmarkedUsersScreen({super.key});

  @override
  ConsumerState<BookmarkedUsersScreen> createState() =>
      _BookmarkedUsersScreenState();
}

class _BookmarkedUsersScreenState extends ConsumerState<BookmarkedUsersScreen> {
  final ValueNotifier<bool> _paginationLoadingNotifier = ValueNotifier(false);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Set<int>? set = ref
          .watch(getBookmarkedUsersIdsStatusStateNotifierProvider)
          .asData
          ?.value;
      ref
          .read(getBookmarkedUsersStatusStateNotifierProvider.notifier)
          .getUsersByIds(set?.toList() ?? []);
    });
    super.initState();
  }

  @override
  dispose() {
    _paginationLoadingNotifier.dispose();
    super.dispose();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    final getUsersState = ref.read(
      getBookmarkedUsersStatusStateNotifierProvider,
    );
    if (!_paginationLoadingNotifier.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (getUsersState.value?.hasMoreData == true) {
        _paginationLoadingNotifier.value = true;
        Set<int>? set = ref
            .watch(getBookmarkedUsersIdsStatusStateNotifierProvider)
            .asData
            ?.value;
        ref
            .read(getBookmarkedUsersStatusStateNotifierProvider.notifier)
            .getMoreUsers(set?.toList() ?? []);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getBookmarkedUsersStatusStateNotifierProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        _paginationLoadingNotifier.value = false;
      }
    });

    ref.listen(getBookmarkedUsersIdsStatusStateNotifierProvider, (
      previous,
      next,
    ) {
      if (next.hasValue && next.value != null) {
        List<int> usersIds = next.value!.toList();
        ref
            .read(getBookmarkedUsersStatusStateNotifierProvider.notifier)
            .updateList(usersIds);
      }
    });
    final state = ref.watch(getBookmarkedUsersStatusStateNotifierProvider);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: CustomScrollView(
          slivers: [
            CustomAppBar(title: "Bookmarked Users"),
            state.when(
              data: (GetUsersState getUsersState) => SliverMainAxisGroup(
                slivers: [
                  UsersList(users: getUsersState.users),
                  PaginationLoading(
                    paginationLoadingNotifier: _paginationLoadingNotifier,
                  ),
                ],
              ),
              error: (error, stackTrace) =>
                  SliverFillRemaining(child: Text(error.toString())),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
