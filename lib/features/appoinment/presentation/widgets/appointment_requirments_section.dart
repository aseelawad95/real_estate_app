import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class AppointmentRequirementsSection extends StatelessWidget {
  const AppointmentRequirementsSection({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Note',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: 3,
          style: TextStyle(color: AppColors.textColor, fontSize: 13),
          decoration: InputDecoration(
            hintText:
                'e.g. Accessible entry required, interest in cellar tour...',
            hintStyle: TextStyle(color: AppColors.grayColor, fontSize: 13),
            filled: true,
            fillColor: AppColors.textFieldColor,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}