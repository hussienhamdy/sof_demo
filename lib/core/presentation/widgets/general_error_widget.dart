import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/core/app_colors.dart';
import 'package:sof_demo/core/failures.dart';

class GeneralErrorWidget extends StatelessWidget {
  final Function onRetry;
  final Failure failure;

  const GeneralErrorWidget({
    super.key,
    required this.onRetry,
    required this.failure,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            failure is NetworkFailure
                ? 'No Internet Connection!'
                : 'General Error Occurred!',
            style: TextTheme.of(context).bodyLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Icon(
            failure is NetworkFailure ? Icons.cloud_off : Icons.error,
            size: 50.sp,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(height: 20.h),
          Text(
            failure is NetworkFailure
                ? 'Please check your network settings and try again.'
                : 'Something went wrong',
            style: TextTheme.of(
              context,
            ).bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 50.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              backgroundColor: AppColors.primaryColor,
            ),
            onPressed: () {
              onRetry();
            },
            child: Text(
              'Retry',
              style: TextTheme.of(
                context,
              ).bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
