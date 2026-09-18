import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

// type=0 مبني على المثال يلي عطيتني (تأكيد حجز موعد).
// وسع الـ switch لما تجيبلي باقي قيم الـ enum من الباك.
IconData notificationTypeIcon(int type) {
  switch (type) {
    case 0:
      return Icons.event_available_outlined;
    default:
      return Icons.notifications_outlined;
  }
}

Color notificationTypeColor(int type) {
  switch (type) {
    case 0:
      return AppColors.fourthColor;
    default:
      return AppColors.primaryColor;
  }
}

String formatNotificationTime(DateTime? date) {
  if (date == null) return '';

  final difference = DateTime.now().difference(date);

  if (difference.inMinutes < 1) return 'الآن';
  if (difference.inMinutes < 60) return 'قبل ${difference.inMinutes} د';
  if (difference.inHours < 24) return 'قبل ${difference.inHours} س';
  if (difference.inDays < 7) return 'قبل ${difference.inDays} يوم';

  return '${date.day}/${date.month}/${date.year}';
}