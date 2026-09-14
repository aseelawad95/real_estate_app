import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class AppointmentWeekdayHeaderRow extends StatelessWidget {
  const AppointmentWeekdayHeaderRow({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels
          .map(
            (label) => SizedBox(
              width: 32,
              child: CustomText(
                text: label,
                textAlign: TextAlign.center,
                fontSize: 12,
                color: AppColors.grayColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
          .toList(),
    );
  }
}