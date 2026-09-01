import 'package:flutter/material.dart';

/// Reusable property listing card (Bayut/Aqarmap style).
class PropertyCard extends StatefulWidget {
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
  late bool _isFavorite = widget.initialIsFavorite;

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteChanged?.call(_isFavorite);
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
          // Bottom gradient for price readability.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
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
    return GestureDetector(
      onTap: _toggleFavorite,
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

// // ---------------------------------------------------------------------------
// // Usage example
// // ---------------------------------------------------------------------------
// class PropertyCardDemo extends StatelessWidget {
//   const PropertyCardDemo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F4F7),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: PropertyCard(
//           imageUrl: 'https://your-image-url.com/villa.jpg',
//           price: '\$12,450,000',
//           title: 'The Azure Horizon Villa',
//           location: 'Dubai Marina, UAE',
//           beds: 6,
//           baths: 8,
//           sqft: 12500,
//           isVerified: true,
//         ),
//       ),
//     );
//   }
// }


// 13. Bonus: صمّم POST /orders بحيث لو نفس الطلب وصل 10 مرات بسبب retries لا ينشئ أكثر من Order، حتى مع وصول الطلبات بالتوازي.
// Idempotency key 
