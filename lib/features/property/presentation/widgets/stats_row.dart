import 'package:flutter/material.dart';
import 'package:real_estate/core/helper_function/app_spacing.dart';
import 'package:real_estate/features/property/domain/entities/property_details.dart';
import 'package:real_estate/features/property/presentation/widgets/state_card.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key, required this.property});

  final PropertyDetails property;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.bed_outlined,
            value: '${property.bedrooms}',
            label: 'Bedrooms',
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: StatCard(
            icon: Icons.bathtub_outlined,
            value: '${property.bathrooms}',
            label: 'Bathrooms',
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: StatCard(
            icon: Icons.square_foot_outlined,
            value: '${property.area}',
            label: 'Sq. Ft.',
          ),
        ),
      ],
    );
  }
}