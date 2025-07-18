import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/features/users/presentation/providers/providers.dart';

class UserBookmarkStatusWidget extends ConsumerWidget {
  final int userId;
  const UserBookmarkStatusWidget({super.key, required this.userId});

  void onClick(WidgetRef ref, bool isbookmarked) {
    ref
        .read(changeUserBookmarkStatusStateNotifierProvider.notifier)
        .changeUserBookmarkStatus(userId, isbookmarked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(changeUserBookmarkStatusStateNotifierProvider, (previous, next) {
      if (next.hasValue && next.value != null) {
        ref
            .read(getBookmarkedUsersIdsStatusStateNotifierProvider.notifier)
            .getBookmarkedUsersIds();
      }
    });

    final bool isBookmarked = ref.watch(
      getBookmarkedUsersIdsStatusStateNotifierProvider.select((
        statusAsyncValue,
      ) {
        return statusAsyncValue.when(
          data: (Set<int> set) => set.contains(userId) == true,
          loading: () => false,
          error: (err, stack) => false,
        );
      }),
    );

    return IconButton(
      onPressed: () {
        onClick(ref, isBookmarked);
      },
      icon: isBookmarked
          ? Icon(Icons.bookmark, color: Colors.white, size: 24.sp)
          : Icon(Icons.bookmark_border, color: Colors.grey, size: 24.sp),
    );
  }
}
