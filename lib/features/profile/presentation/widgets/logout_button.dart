
import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';


class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: AppColors.dangerBackground),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusOption.button),
          ),
        ),
        icon: Icon(Icons.logout, color: AppColors.dangerColor, size: 18),
        label: CustomText(
          text: 'Logout',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.dangerColor,
        ),
      ),
    );
  }
}