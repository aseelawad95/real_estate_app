import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class AppointmentCalendarDayCell extends StatelessWidget {
  const AppointmentCalendarDayCell({
    super.key,
    required this.day,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  final int day;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: CustomText(
          text: '$day',
          color: isSelected
              ? Colors.white
              : isDisabled
                  ? AppColors.grayColor
                  : AppColors.primaryText,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}