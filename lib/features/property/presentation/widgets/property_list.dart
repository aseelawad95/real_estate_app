// lib/features/property/presentation/widgets/property_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/features/favorite/presentation/bloc/toggleFavorite/toggle_favorite_cubit.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/bloc/propertyDetails/property_details_cubit.dart';
import 'package:real_estate/features/property/presentation/pages/property_details_page.dart';
import 'package:real_estate/features/property/presentation/widgets/property_card.dart';
import 'package:real_estate/service_locator.dart';

/// Renders a list of properties.
///
/// If [properties] is provided, it renders that fixed list directly
/// (used by screens like "properties by type" that already have the data).
/// If [properties] is null, it listens to [GetpropertyCubit] and renders
/// whatever that cubit's current state holds (used by the main feed).
class PropertyListPage extends StatelessWidget {
  const PropertyListPage({super.key, this.properties});

  final List<Property>? properties;

  @override
  Widget build(BuildContext context) {
    if (properties != null) {
      return _PropertyListView(properties: properties!);
    }

    return BlocListener<GetpropertyCubit, GetpropertyState>(
      listener: (context, state) {
        if (state is GetpropertyError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<GetpropertyCubit, GetpropertyState>(
        builder: (context, state) {
          return switch (state) {
            GetpropertyLoading() =>
              const Center(child: CircularProgressIndicator()),
            GetpropertyError(:final message) => Center(child: Text(message)),
            GetpropertyLoaded(:final property) =>
              _PropertyListView(properties: property),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

/// The actual scrollable list + its shared cubits.
///
/// Both [ToggleFavoriteCubit] and [PropertyDetailsCubit] are provided once
/// for the whole list rather than once per card — there's no reason for
/// each item to carry its own [PropertyDetailsCubit] instance.
class _PropertyListView extends StatelessWidget {
  const _PropertyListView({required this.properties});

  final List<Property> properties;

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const Center(child: Text('No properties found'));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ToggleFavoriteCubit>()),
        BlocProvider(create: (_) => sl<PropertyDetailsCubit>()),
      ],
      child: BlocListener<PropertyDetailsCubit, PropertyDetailsState>(
        listener: _handlePropertyDetailsState,
        child: ListView.separated(
          padding: EdgeInsets.only(bottom: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: properties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final property = properties[index];
            return PropertyCard(
              key: ValueKey(property.id),
              id: property.id,
              sqft: property.area,
              baths: property.bathrooms,
              beds: property.bedrooms,
              imageUrl: property.images.isNotEmpty ? property.images[0] : '',
              price: property.price,
              title: property.title ?? '',
              listingType: property.location?.city ?? property.listingType,
              isVerified: true,
              initialIsFavorite: property.isFavourite,
              onTap: () => context
                  .read<PropertyDetailsCubit>()
                  .propertyDetails(property.id),
            );
          },
        ),
      ),
    );
  }

  void _handlePropertyDetailsState(
    BuildContext context,
    PropertyDetailsState state,
  ) {
    switch (state) {
      case PropertyDetailsLoading():
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      case PropertyDetailsLoaded(:final propertyDetails):
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyDetailsPage(property: propertyDetails),
          ),
        );
      case PropertyDetailsError(:final message):
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      default:
        break;
    }
  }
}