// lib/common/widgets/custom_sliver_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Ensure you import screenutil if using .sp

class CustomAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final bool hasBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.hasBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: hasBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            )
          : null,
      backgroundColor: Colors.black,
      title: Text(title, style: TextStyle(color: Colors.white)),
      pinned: true,
      floating: false,
      expandedHeight: 0.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: Colors.black),
      ),
      actions: actions,
    );
  }
}
