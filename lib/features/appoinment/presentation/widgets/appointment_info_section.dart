import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class AppointmentPropertyInfoSection extends StatelessWidget {
  const AppointmentPropertyInfoSection({
    super.key,
    required this.title,
    required this.location,
    required this.price,
  });

  final String title;
  final String location;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        ),
        const SizedBox(height: 4),
        CustomText(
          text: location,
          fontSize: 14,
          color: AppColors.textColor,
        ),
        const SizedBox(height: 6),
        CustomText(
          text: "\$${price.toString()}",
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}