import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/core/app_colors.dart';
import 'package:sof_demo/core/extensions.dart';
import 'package:sof_demo/features/users/domain/entities/user_reputation.dart';

class UserReputationListItem extends StatelessWidget {
  final UserReputation reputation;

  const UserReputationListItem({super.key, required this.reputation});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  reputation.reputationHistoryType.icon,
                  color: reputation.reputationHistoryType.iconColor,
                  size: 32.sp,
                ),
                SizedBox(height: 4.h),
                Text(
                  reputation.reputationChange.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    reputation.reputationHistoryType.displayName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    reputation.creationDate.formattedDate,
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link, color: Colors.blueGrey[300], size: 18.sp),
                  Text(
                    'Post ID: ${reputation.postId}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.blueGrey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
