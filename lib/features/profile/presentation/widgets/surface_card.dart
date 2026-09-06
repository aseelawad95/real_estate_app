import 'package:flutter/material.dart';
import 'package:real_estate/features/profile/presentation/pages/profile_page.dart';

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({super.key, 
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.md),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RadiusOption.card),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}