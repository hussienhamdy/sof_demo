import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sof_demo/core/app_colors.dart';

class PaginationLoading extends StatelessWidget {
  final ValueNotifier<bool> paginationLoadingNotifier;
  const PaginationLoading({super.key, required this.paginationLoadingNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: paginationLoadingNotifier,
      builder: (context, value, child) {
        if (value == true) {
          return SliverToBoxAdapter(
            child: Center(
              child: SpinKitChasingDots(
                color: AppColors.indicator,
                size: 40.sp,
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
