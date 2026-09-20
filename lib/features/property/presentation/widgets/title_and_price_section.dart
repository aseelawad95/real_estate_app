import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';

class TitleAndPriceSection extends StatelessWidget {
  const TitleAndPriceSection({super.key, 
    required this.property,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  final PropertyDetails property;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomText(
                text: property.title?? "",
                color: AppColors.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // InkWell(
            //   onTap: onFavoriteTap,
            //   customBorder: const CircleBorder(),
            //   child: Padding(
            //     padding: const EdgeInsets.all(4),
            //     child: Icon(
            //       isFavorite ? Icons.favorite : Icons.favorite_border,
            //       color: isFavorite ? Colors.redAccent : AppColors.grayColor,
            //       size: 22,
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
             Icon(Icons.location_on_outlined,
                size: 15, color: AppColors.textColor),
            const SizedBox(width: 4),
            Expanded(
              child: CustomText(
                text: property.location!.country,
                color: AppColors.textColor,
                fontSize: 13,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              text: '\$${_formatPrice(property.price)}',
              color: AppColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            // const SizedBox(width: 6),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 3),
            //   child: CustomText(
            //     text: '\$${_formatCompact(property.price)}',
            //     color: AppColors.grayColor,
            //     fontSize: 12,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  String _formatPrice(double value) {
    final s = value.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }

  String _formatCompact(double value) {
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}k';
    return value.toStringAsFixed(0);
  }
}