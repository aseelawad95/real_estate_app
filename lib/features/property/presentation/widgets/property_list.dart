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
/// [shrinkWrap]/[physics] control how the internal ListView behaves:
/// - When this widget is embedded inside another scrollable (e.g. Home's
///   CustomScrollView), pass shrinkWrap: true + NeverScrollableScrollPhysics
///   so the OUTER scrollable is the only one that scrolls.
/// - When this widget IS the whole screen's scrollable (e.g. the dedicated
///   search page), pass shrinkWrap: false + a normal scrollable physics so
///   it can lazily build items and actually scroll on its own.
class PropertyListPage extends StatelessWidget {
  const PropertyListPage({
    super.key,
    this.properties,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  final List<Property>? properties;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (properties != null) {
      return _PropertyListView(
        properties: properties!,
        shrinkWrap: shrinkWrap,
        physics: physics,
      );
    }

    return BlocListener<GetpropertyCubit, GetpropertyState>(
      listener: (context, state) {
        if (state is GetpropertyError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocBuilder<GetpropertyCubit, GetpropertyState>(
        builder: (context, state) {
          return switch (state) {
            GetpropertyLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            GetpropertyError(:final message) => Center(child: Text(message)),
            GetpropertyLoaded(:final property) => _PropertyListView(
              properties: property,
              shrinkWrap: shrinkWrap,
              physics: physics,
            ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

class _PropertyListView extends StatelessWidget {
  const _PropertyListView({
    required this.properties,
    required this.shrinkWrap,
    required this.physics,
  });

  final List<Property> properties;
  final bool shrinkWrap;
  final ScrollPhysics physics;

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
          padding: const EdgeInsets.only(bottom: 16),
          shrinkWrap: shrinkWrap,
          physics: physics,
          itemCount: properties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final property = properties[index];
            final favCubit = sl<ToggleFavoriteCubit>();
            debugPrint(
              'FAV DEBUG -> id: ${property.id} | api: ${property.isFavourite} | '
              'override: ${favCubit.isFavorited(property.id)} | closed: ${favCubit.isClosed}',
            );
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
              onTap: () => context.read<PropertyDetailsCubit>().propertyDetails(
                property.id,
              ),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      default:
        break;
    }
  }
}
