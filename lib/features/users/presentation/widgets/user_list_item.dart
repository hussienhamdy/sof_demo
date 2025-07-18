import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/core/app_colors.dart';
import 'package:sof_demo/core/enums.dart';
import 'package:sof_demo/core/routes.dart';
import 'package:sof_demo/features/users/domain/entities/user.dart';
import 'package:sof_demo/features/users/presentation/widgets/badge_count.dart';
import 'package:sof_demo/features/users/presentation/widgets/user_bookmark_status_widget.dart';

class UserListItem extends StatelessWidget {
  final User user;
  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(Routes.userReputationsScreen, arguments: user.userId),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: AppColors.primaryColor, width: 1.w),
        ),
        color: AppColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: CachedNetworkImage(
                        imageUrl: user.profileImage,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          return Icon(Icons.broken_image, size: 50.sp);
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              BadgeCount(
                                badgeType: BadgeType.bronze,
                                count: user.badgeCount.bronzeCount,
                              ),
                              SizedBox(width: 10.w),
                              BadgeCount(
                                badgeType: BadgeType.silver,
                                count: user.badgeCount.silverCount,
                              ),
                              SizedBox(width: 10.w),
                              BadgeCount(
                                badgeType: BadgeType.gold,
                                count: user.badgeCount.goldCount,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              UserBookmarkStatusWidget(userId: user.userId),
            ],
          ),
        ),
      ),
    );
  }
}
