import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rate, this.size = 14});

  final int rate;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rate ? Icons.star_rounded : Icons.star_border_rounded,
          size: size,
          color: AppColors.secondaryColor,
        );
      }),
    );
  }
}