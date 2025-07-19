import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_demo/core/failures.dart';
import 'package:sof_demo/core/presentation/widgets/general_error_widget.dart';
import 'package:sof_demo/features/users/domain/entities/get_user_reputation_state.dart';
import 'package:sof_demo/features/users/presentation/providers/providers.dart';
import 'package:sof_demo/features/users/presentation/widgets/custom_app_bar.dart';
import 'package:sof_demo/features/users/presentation/widgets/pagination_loading.dart';
import 'package:sof_demo/features/users/presentation/widgets/shimmer_list.dart';
import 'package:sof_demo/features/users/presentation/widgets/user_reputation_list.dart';

class UserReputationHistoryScreen extends ConsumerStatefulWidget {
  final int userId;
  const UserReputationHistoryScreen({super.key, required this.userId});

  @override
  ConsumerState<UserReputationHistoryScreen> createState() =>
      _UserReputationHistoryScreenState();
}

class _UserReputationHistoryScreenState
    extends ConsumerState<UserReputationHistoryScreen> {
  final ValueNotifier<bool> _paginationLoadingNotifier = ValueNotifier(false);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(getUserReputationsStateNotifierProvider.notifier)
          .getUserReputations(widget.userId);
    });
    super.initState();
  }

  @override
  dispose() {
    _paginationLoadingNotifier.dispose();
    super.dispose();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    final getUserReputationState = ref.read(
      getUserReputationsStateNotifierProvider,
    );
    if (!_paginationLoadingNotifier.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (getUserReputationState.value?.hasMoreData == true) {
        _paginationLoadingNotifier.value = true;
        ref
            .read(getUserReputationsStateNotifierProvider.notifier)
            .getMoreUserReputations(widget.userId);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getUserReputationsStateNotifierProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        _paginationLoadingNotifier.value = false;
      }
    });
    final state = ref.watch(getUserReputationsStateNotifierProvider);
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: CustomScrollView(
          slivers: [
            CustomAppBar(title: "User Reputation List"),
            state.when(
              data: (GetUserReputationState getUserReputationState) =>
                  SliverMainAxisGroup(
                    slivers: [
                      UserReputationList(
                        reputations: getUserReputationState.reputations,
                      ),
                      PaginationLoading(
                        paginationLoadingNotifier: _paginationLoadingNotifier,
                      ),
                    ],
                  ),
              error: (error, stackTrace) => SliverFillRemaining(
                child: GeneralErrorWidget(
                  failure: error as Failure,
                  onRetry: () {
                    ref
                        .read(getUserReputationsStateNotifierProvider.notifier)
                        .getUserReputations(widget.userId);
                  },
                ),
              ),
              loading: () => const ShimmerList(),
            ),
          ],
        ),
      ),
    );
  }
}
