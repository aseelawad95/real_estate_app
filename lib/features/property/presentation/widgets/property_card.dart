import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/core/helper_function/TokenHelper.dart';
import 'package:real_estate/core/helper_function/shared_prefs.dart';
import 'package:real_estate/features/favorite/presentation/bloc/toggleFavorite/toggle_favorite_cubit.dart';

/// Reusable property listing card (Bayut/Aqarmap style).
class PropertyCard extends StatefulWidget {
  final int id;
  final String imageUrl;
  final double price;
  final String title;
  final String location;
  final int beds;
  final int baths;
  final int sqft;
  final bool isVerified;
  final bool initialIsFavorite;
  final ValueChanged<bool>? onFavoriteChanged;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.beds,
    required this.baths,
    required this.sqft,
    this.isVerified = false,
    this.initialIsFavorite = false,
    this.onFavoriteChanged,
    this.onTap,
  });

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  late bool _isFavorite;
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialIsFavorite;
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await TokenHelper.getUserId();

    setState(() {
      userId = id;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.15),
      child: InkWell(
        onTap: widget.onTap,
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
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2A41),
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildLocationRow(),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFE9ECEF)),
                  const SizedBox(height: 12),
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
          widget.imageUrl.isNotEmpty
              ? Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFE9ECEF),
                    child: const Icon(Icons.broken_image, size: 32),
                  ),
                )
              : Container(
                  color: const Color(0xFFE9ECEF),
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
          if (widget.isVerified)
            Positioned(top: 14, left: 14, child: _buildVerifiedBadge()),
          Positioned(top: 14, right: 14, child: _buildFavoriteButton()),
          Positioned(
            left: 16,
            bottom: 14,
            child: Text(
              widget.price.toString(),
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

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5A623),
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

  Widget _buildFavoriteButton() {
    return BlocListener<ToggleFavoriteCubit, ToggleFavoriteState>(
      listener: (context, state) {
        if (state is ToggleFavoriteLoaded && state.propertyId == widget.id) {
          setState(() => _isFavorite = state.isFavorited);
          widget.onFavoriteChanged?.call(_isFavorite);
        }
        if (state is ToggleFavoriteError && state.propertyId == widget.id) {
          setState(() => _isFavorite = !_isFavorite);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          if (userId == null) return;

          setState(() => _isFavorite = !_isFavorite);

          context.read<ToggleFavoriteCubit>().toggleFavorite(
            widget.id,
            userId!,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 246, 229, 229).withOpacity(0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 18,
            color: _isFavorite ? Colors.redAccent : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 16,
          color: Color(0xFF8A94A6),
        ),
        const SizedBox(width: 4),
        Text(
          widget.location,
          style: const TextStyle(fontSize: 13, color: Color(0xFF8A94A6)),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statItem(Icons.bed_outlined, '${widget.beds} Beds'),
        const SizedBox(width: 20),
        _statItem(Icons.bathtub_outlined, '${widget.baths} Baths'),
        const SizedBox(width: 20),
        _statItem(Icons.square_foot_outlined, '${widget.sqft} sqft'),
      ],
    );
  }

  Widget _statItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF1B2A41)),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1B2A41),
          ),
        ),
      ],
    );
  }
}