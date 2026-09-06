
import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';
import 'package:real_estate/features/profile/presentation/widgets/app_text_field.dart';
import 'package:real_estate/features/profile/presentation/widgets/surface_card.dart';


class EditProfileCard extends StatelessWidget {
  const EditProfileCard({super.key, 
    required this.nameController,
    required this.emailController,
    required this.onUpdate,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Edit Profile',
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: Spacing.md),
          CustomText(
            text: 'Full Name',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: Spacing.xs),
          AppTextField(controller: nameController),
          const SizedBox(height: Spacing.md),
          CustomText(
            text: 'Email Address',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: Spacing.xs),
          AppTextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: Spacing.lg),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onUpdate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusOption.button),
                ),
              ),
              child: CustomText(
                text: 'Update Profile',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
