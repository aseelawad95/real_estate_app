import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({super.key, 
    required this.controller,
    this.keyboardType,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusOption.field),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}