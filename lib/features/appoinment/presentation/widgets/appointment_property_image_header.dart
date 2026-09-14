import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class AppointmentPropertyImageHeader extends StatelessWidget {
  const AppointmentPropertyImageHeader({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.grayColor.withOpacity(0.2),
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.grayColor,
                child: const Icon(Icons.home_outlined, size: 48),
              ),
            ),
          ),
          // const Positioned(
          //   top: 12,
          //   left: 12,
          //   child: AppointmentVerifiedBadge(),
          // ),
        ],
      ),
    );
  }
}