import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, 
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.textFieldColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryColor),
          const SizedBox(height: 6),
          CustomText(
            text: value,
            color: AppColors.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 2),
          CustomText(
            text: label,
            color: AppColors.textColor,
            fontSize: 11,
          ),
        ],
      ),
    );
  }
}
