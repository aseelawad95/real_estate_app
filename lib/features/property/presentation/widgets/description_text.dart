import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key, 
    required this.text,
    required this.isExpanded,
    required this.onToggle,
  });

  final String text;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          color: AppColors.textColor,
          fontSize: 13.5,
          maxLines: isExpanded ? null : 3,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onToggle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: isExpanded ? 'Read Less' : 'Read More',
                color: AppColors.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 18,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}