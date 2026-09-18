import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.dangerColor),
            const SizedBox(height: 12),
            CustomText(
              text: message,
              textAlign: TextAlign.center,
              color: AppColors.textColor,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
              child: const CustomText(text: 'إعادة المحاولة', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}