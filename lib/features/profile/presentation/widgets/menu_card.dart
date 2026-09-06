import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';
import 'package:real_estate/features/profile/presentation/widgets/surface_card.dart';


class MenuCard extends StatelessWidget {
  const MenuCard({super.key, 
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RadiusOption.card),
      child: SurfaceCard(
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.fourthColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.fourthColor, size: 20),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: CustomText(
                text: label,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textColor,
            ),
          ],
        ),
      ),
    );
  }
}