import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/core/routes.dart';
import 'package:sof_demo/features/users/domain/entities/get_users_state.dart';
import 'package:sof_demo/features/users/presentation/providers/providers.dart';
import 'package:sof_demo/features/users/presentation/widgets/custom_app_bar.dart';
import 'package:sof_demo/features/users/presentation/widgets/shimmer_list.dart';
import 'package:sof_demo/features/users/presentation/widgets/users_list.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  final ValueNotifier<bool> _paginationLoadingNotifier = ValueNotifier(false);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .watch(getBookmarkedUsersIdsStatusStateNotifierProvider.notifier)
          .getBookmarkedUsersIds();
      ref.read(getUsersStateNotifierProvider.notifier).getUsers();
    });
    super.initState();
  }

  @override
  dispose() {
    _paginationLoadingNotifier.dispose();
    super.dispose();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    final getUsersState = ref.read(getUsersStateNotifierProvider);
    if (!_paginationLoadingNotifier.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (getUsersState.value?.hasMoreData == true) {
        _paginationLoadingNotifier.value = true;
        ref.read(getUsersStateNotifierProvider.notifier).getMoreUsers();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getUsersStateNotifierProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        _paginationLoadingNotifier.value = false;
      }
    });
    final state = ref.watch(getUsersStateNotifierProvider);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: CustomScrollView(
          slivers: [
            CustomAppBar(
              hasBackButton: false,
              title: "Users List",
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(Routes.bookmarkedUsersScreen);
                  },
                  icon: Icon(Icons.star, color: Colors.white, size: 24.sp),
                ),
              ],
            ),
            state.when(
              data: (GetUsersState getUsersState) => SliverMainAxisGroup(
                slivers: [
                  UsersList(users: getUsersState.users),
                  ValueListenableBuilder(
                    valueListenable: _paginationLoadingNotifier,
                    builder: (context, value, child) {
                      if (value == true) {
                        return SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                      }
                    },
                  ),
                ],
              ),
              error: (error, stackTrace) =>
                  SliverFillRemaining(child: Text(error.toString())),
              loading: () => const ShimmerList(),
            ),
          ],
        ),
      ),
    );
  }
}
