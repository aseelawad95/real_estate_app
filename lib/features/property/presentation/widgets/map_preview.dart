import 'package:flutter/material.dart';
import 'package:real_estate/core/constants/app_colors.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 140,
        width: double.infinity,
        color: const Color(0xFFDCE6E0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // TODO: استبدل هذا بـ GoogleMap widget الحقيقي
            Container(color: const Color(0xFFE3ECE6)),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Icons.location_on,
                  color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
