import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/core/enums.dart';

class BadgeCount extends StatelessWidget {
  final BadgeType badgeType;
  final int count;
  const BadgeCount({super.key, required this.count, required this.badgeType});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (badgeType == BadgeType.bronze)
          Icon(Icons.star, color: Colors.brown, size: 16.sp),
        if (badgeType == BadgeType.silver)
          Icon(Icons.star_border_rounded, color: Colors.grey, size: 16.sp),
        if (badgeType == BadgeType.gold)
          Icon(Icons.star, color: Colors.yellow, size: 16.sp),
        SizedBox(height: 4.h),
        Text(
          '$count',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[300]),
        ),
      ],
    );
  }
}
