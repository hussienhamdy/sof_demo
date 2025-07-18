import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyBookmarks extends StatelessWidget {
  const EmptyBookmarks({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Bookmarks Found',
            style: TextTheme.of(context).bodyLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Icon(
            Icons.bookmark_border,
            size: 50.sp,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(height: 20.h),
          Text(
            'You have not bookmarked any users yet.',
            style: TextTheme.of(
              context,
            ).bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
