import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: title,
      color: AppColors.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
  }
}