import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';
import 'package:real_estate/features/property/presentation/widgets/owner_card.dart';
import 'package:real_estate/features/property/presentation/widgets/description_text.dart';
import 'package:real_estate/features/property/presentation/widgets/image_gallery.dart';
import 'package:real_estate/features/property/presentation/widgets/map_preview.dart';
import 'package:real_estate/features/property/presentation/widgets/section_title.dart';
import 'package:real_estate/features/property/presentation/widgets/stats_row.dart';
import 'package:real_estate/features/property/presentation/widgets/title_and_price_section.dart';

class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key, required this.property});

  final PropertyDetails property;

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentImage = 0;
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.property;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ImageGallery(
              images: property.images,
              currentIndex: _currentImage,
              pageController: _pageController,
              onPageChanged: (i) => setState(() => _currentImage = i),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleAndPriceSection(
                      property: property,
                      isFavorite: _isFavorite,
                      onFavoriteTap: () =>
                          setState(() => _isFavorite = !_isFavorite),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    StatsRow(property: property),
                    const SizedBox(height: AppSpacing.lg),
                    SectionTitle(title: 'Property Description'),
                    const SizedBox(height: AppSpacing.sm),
                    DescriptionText(
                      text: property.description ?? "",
                      isExpanded: _isDescriptionExpanded,
                      onToggle: () => setState(
                        () => _isDescriptionExpanded = !_isDescriptionExpanded,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionTitle(title: 'Location'),
                        CustomText(
                          text: 'View On Map',
                          color: AppColors.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            // TODO: افتح الخريطة الكاملة
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const MapPreview(),
                    const SizedBox(height: AppSpacing.lg),
                    SectionTitle(title: 'Listing Owner'),
                    const SizedBox(height: AppSpacing.sm),
                    OwnerCard(owner: property.owner),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}