import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sof_demo/core/app_colors.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onConfirm;
  const CustomPopup({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close),
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                title,
                style: TextTheme.of(
                  context,
                ).bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
                child: Text(
                  subtitle,
                  style: TextTheme.of(context).bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 100.w,
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextTheme.of(
                            context,
                          ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  ElevatedButton(
                    onPressed: () {
                      onConfirm();
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      width: 100.w,
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextTheme.of(
                            context,
                          ).bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
