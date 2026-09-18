import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 56,
            color: AppColors.grayColor,
          ),
          const SizedBox(height: 12),
          CustomText(
            text: 'ما في إشعارات حالياً',
            fontSize: 14,
            color: AppColors.textColor,
          ),
        ],
      ),
    );
  }
}