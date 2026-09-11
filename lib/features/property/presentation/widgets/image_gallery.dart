import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/property/presentation/widgets/circle_icon_button.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key, 
    required this.images,
    required this.currentIndex,
    required this.pageController,
    required this.onPageChanged,
  });

  final List<String> images;
  final int currentIndex;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.textFieldColor,
                  child:  Icon(Icons.image_not_supported_outlined,
                      size: 40, color: AppColors.textColor),
                ),
              );
            },
          ),

          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black26, Colors.transparent],
                stops: [0.0, 0.3],
              ),
            ),
          ),

          // App Bar
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleIconButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                      const CustomText(
                        text: 'EstateGold',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                      CircleIconButton(
                        icon: Icons.favorite,
                        onTap: () {
                          // TODO: مشاركة العقار
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Verified Badge
          // Positioned(
          //   top: 70,
          //   left: AppSpacing.md,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //     decoration: BoxDecoration(
          //       color: AppColors.secondaryColor,
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: const Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Icon(Icons.verified, size: 14, color: Colors.white),
          //         SizedBox(width: 4),
          //         CustomText(
          //           text: 'VERIFIED LISTING',
          //           color: Colors.white,
          //           fontSize: 11,
          //           fontWeight: FontWeight.w700,
          //           letterSpacing: 0.3,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // Photo counter
          Positioned(
            bottom: AppSpacing.lg + 10,
            right: AppSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.photo_camera_outlined,
                      size: 13, color: Colors.white),
                  const SizedBox(width: 4),
                  CustomText(
                    text: '${currentIndex + 1}/${images.length} Photos',
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
