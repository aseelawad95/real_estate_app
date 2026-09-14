import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/property/domain/entities/review.dart';
import 'package:real_estate/features/property/presentation/widgets/rating_stars.dart';
import 'package:real_estate/features/property/presentation/widgets/review_card.dart';

class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({super.key, required this.reviews});

  final List<Review> reviews;

  double get _averageRate {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<int>(0, (sum, r) => sum + r.rate);
    return total / reviews.length;
  }

  int _countFor(int star) => reviews.where((r) => r.rate == star).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: CustomText(
          text: 'Reviews',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: reviews.isEmpty
          ? _buildEmptyState()
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _buildSummaryCard(),
                const SizedBox(height: AppSpacing.lg),
                CustomText(
                  text: '${reviews.length} Reviews',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...reviews.map((r) => ReviewCard(review: r)),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.reviews_outlined,
            size: 56,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: AppSpacing.sm),
          CustomText(
            text: 'No reviews yet',
            fontSize: 14,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CustomText(
                text: _averageRate.toStringAsFixed(1),
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 4),
              RatingStars(rate: _averageRate.round(), size: 14),
              const SizedBox(height: 4),
              CustomText(
                text: '${reviews.length} ratings',
                fontSize: 11,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              children: List.generate(5, (index) {
                final star = 5 - index;
                final count = _countFor(star);
                final ratio = reviews.isEmpty ? 0.0 : count / reviews.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      CustomText(text: '$star', fontSize: 11),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.star_rounded,
                        size: 11,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: ratio,
                            minHeight: 6,
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(0.1),
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 18,
                        child: CustomText(
                          text: '$count',
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}