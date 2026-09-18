import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/core/helper_function/TokenHelper.dart';
import 'package:real_estate/features/favorite/presentation/bloc/toggleFavorite/toggle_favorite_cubit.dart';

class PropertyCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final double price;
  final String title;
  final String listingType;
  final int beds;
  final int baths;
  final int sqft;
  final bool isVerified;
  final bool initialIsFavorite;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.listingType,
    required this.beds,
    required this.baths,
    required this.sqft,
    this.isVerified = false,
    this.initialIsFavorite = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      // shadowColor: Colors.black.withOpacity(0.19),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildLocationRow(),
                  const SizedBox(height: 12),
                  Divider(height: 1, color: AppColors.dividerColor),
                  _buildStatsRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.dividerColor,
                    child: const Icon(Icons.broken_image, size: 32),
                  ),
                )
              : Container(
                  color: AppColors.dividerColor,
                  child: const Icon(Icons.image_not_supported, size: 32),
                ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),
          if (isVerified)
            Positioned(top: 14, left: 14, child: const _VerifiedBadge()),
          Positioned(
            top: 14,
            right: 14,
            child: _FavoriteButton(
              propertyId: id,
              initialIsFavorite: initialIsFavorite,
            ),
          ),
          Positioned(
            left: 16,
            bottom: 14,
            child: Text(
              price.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(
          listingType == 'sale' ? Icons.sell_outlined : Icons.vpn_key_outlined,
          size: 16,
          color: AppColors.grayColor,
        ),
        const SizedBox(width: 4),
        Text(
          listingType,
          style: TextStyle(fontSize: 13, color: AppColors.grayColor),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statItem(Icons.bed_outlined, '$beds Beds'),
        const SizedBox(width: 20),
        _statItem(Icons.bathtub_outlined, '$baths Baths'),
        const SizedBox(width: 20),
        _statItem(Icons.square_foot_outlined, '$sqft sqft'),
      ],
    );
  }

  Widget _statItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primaryText),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({
    required this.propertyId,
    required this.initialIsFavorite,
  });

  final int propertyId;
  final bool initialIsFavorite;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleFavoriteCubit, ToggleFavoriteState>(
      builder: (context, state) {
        final cubit = context.read<ToggleFavoriteCubit>();
        final isFavorite = cubit.isFavorited(propertyId) ?? initialIsFavorite;

        if (state is ToggleFavoriteError && state.propertyId == propertyId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          });
        }

        return GestureDetector(
          onTap: () async {
            final userId = await TokenHelper.getUserId();
            if (userId == null) return;
            cubit.toggleFavorite(propertyId, userId);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: isFavorite ? AppColors.dangerColor : Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.verifiedBadgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 14, color: Colors.white),
          SizedBox(width: 4),
          Text(
            'VERIFIED',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}