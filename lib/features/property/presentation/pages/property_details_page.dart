import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_btn.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/appoinment/presentation/pages/create_appointment_page.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';
import 'package:real_estate/features/property/presentation/widgets/all_review.dart';
import 'package:real_estate/features/property/presentation/widgets/location_map.dart';
import 'package:real_estate/features/property/presentation/widgets/owner_card.dart';
import 'package:real_estate/features/property/presentation/widgets/description_text.dart';
import 'package:real_estate/features/property/presentation/widgets/image_gallery.dart';
import 'package:real_estate/features/property/presentation/widgets/map_preview.dart';
import 'package:real_estate/features/property/presentation/widgets/review_card.dart';
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
              isFavorite: property.isFavourite,
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
                decoration: BoxDecoration(
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
                        if (property.location != null)
                          CustomText(
                            text: 'View On Map',
                            color: AppColors.primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LocationMapScreen(
                                    location: property.location!,
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (property.location != null)
                      MapPreview(location: property.location!)
                    else
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Location not available',
                          color: Colors.grey,
                        ),
                      ),
                   
                    const SizedBox(height: AppSpacing.lg),
                    SectionTitle(title: 'Listing Owner'),
                    const SizedBox(height: AppSpacing.sm),
                    OwnerCard(owner: property.owner),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionTitle(title: 'Reviews'),
                        CustomText(
                          text: 'See All',
                          color: AppColors.primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AllReviewsScreen(reviews: property.reviews),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ...property.reviews.map((r) => ReviewCard(review: r)),
                  BasicAppButton(
                    height: 50,
                    title: "Create Appointment",
                    onPressed: () {
                     Navigator.pushReplacement(context, 
                     MaterialPageRoute(builder: (_) 
                     => CreateAppointmentPage(propertyId:
                      property.id,
                      imageUrl: property.images[0],
                      location: property.location!.country,
                           price: property.price,
                           title: property.title!,
                      )));
                  },),
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
