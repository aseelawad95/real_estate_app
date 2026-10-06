import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/basic_app_button.dart';
import 'package:real_estate/common/widgets/custom_btn.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/TokenHelper.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/appoinment/presentation/pages/create_appointment_page.dart';
import 'package:real_estate/features/favorite/presentation/bloc/toggleFavorite/toggle_favorite_cubit.dart';
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
import 'package:real_estate/service_locator.dart';

class PropertyDetailsPage extends StatefulWidget {
  const PropertyDetailsPage({super.key, required this.property});

  final PropertyDetails property;

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final PageController _pageController = PageController();
  int _currentImage = 0;
  bool _isDescriptionExpanded = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.property;

    return BlocProvider.value(
      value: sl<ToggleFavoriteCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ImageGallery(
                propertyId: property.id,
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
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
                      BlocBuilder<ToggleFavoriteCubit, ToggleFavoriteState>(
                        builder: (context, _) {
                          final cubit = context.read<ToggleFavoriteCubit>();
                          return TitleAndPriceSection(
                            property: property,
                            isFavorite: cubit.isFavoriteOr(
                              property.id,
                              property.isFavourite,
                            ),
                            onFavoriteTap: () async {
                              final userId = await TokenHelper.getUserId();
                              if (userId == null) return;
                              cubit.toggleFavorite(property.id, userId);
                            },
                          );
                        },
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
                          () =>
                              _isDescriptionExpanded = !_isDescriptionExpanded,
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
                      OwnerCard(
                        owner: property.owner,
                        propertyId: property.id,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      if (property.reviews.isNotEmpty) ...[
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
                                    builder: (_) => AllReviewsScreen(
                                      reviews: property.reviews,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ...property.reviews.map((r) => ReviewCard(review: r)),
                      ],
                      BasicAppButton(
                        height: 50,
                        title: "Create Appointment",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CreateAppointmentPage(
                                propertyId: property.id,
                                imageUrl: property.images[0],
                                location: property.location!.country,
                                price: property.price,
                                title: property.title!,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}