import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class AppointmentAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AppointmentAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
       backgroundColor: Colors.white,
      elevation: 0,
      leading: BackButton(color: AppColors.primaryText),
      title: CustomText(
        text: 'Book a Viewing',
        color: AppColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}