import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/profile/presentation/bloc/editUser/edit_user_cubit.dart';
import 'package:real_estate/features/profile/presentation/bloc/get_userby_id/get_userby_id_cubit.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';
import 'package:real_estate/features/profile/presentation/widgets/app_text_field.dart';
import 'package:real_estate/features/profile/presentation/widgets/surface_card.dart';

class EditProfileCard extends StatelessWidget {
  const EditProfileCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.onUpdate, required this.userId,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onUpdate;
   final String userId;
  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: BlocConsumer<EditUserCubit, EditUserState>(
        listener: (context, state) {
          if (state is EditUserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is EditUserSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("تم التعديل بنجاح ✅")));
              context.read<GetUserbyIdCubit>().getUserById(userId);
          }
        },
        builder: (context, state) {
          final isSaving = state is EditUserLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Edit Profile',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSaving
                    ? SizedBox(
                        key: const ValueKey('loading'),
                        height: 48,
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : BasicAppButton(
                        height: 50,
                        key: const ValueKey('button'),
                        title: 'Update Profile',
                        onPressed: onUpdate,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
