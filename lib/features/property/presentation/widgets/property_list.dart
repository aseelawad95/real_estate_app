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

class PropertyListPage extends StatelessWidget {
  const PropertyListPage({
    super.key,
    this.properties,
    this.asSliver = false,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
  });

  final List<Property>? properties;
  final bool asSliver;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (properties != null) {
      return _PropertyListView(
        properties: properties!,
        asSliver: asSliver,
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
            GetpropertyLoading() => _wrap(
              const Center(child: CircularProgressIndicator()),
            ),
            GetpropertyError(:final message) => _wrap(
              Center(child: Text(message)),
            ),
            GetpropertyLoaded(:final property) => _PropertyListView(
              properties: property,
              asSliver: asSliver,
              shrinkWrap: shrinkWrap,
              physics: physics,
            ),
            _ => _wrap(const SizedBox.shrink()),
          };
        },
      ),
    );
  }

  Widget _wrap(Widget child) =>
      asSliver ? SliverToBoxAdapter(child: child) : child;
}

class _PropertyListView extends StatelessWidget {
  const _PropertyListView({
    required this.properties,
    required this.asSliver,
    required this.shrinkWrap,
    required this.physics,
  });

  final List<Property> properties;
  final bool asSliver;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      const empty = Center(child: Text('No properties found'));
      return asSliver ? const SliverToBoxAdapter(child: empty) : empty;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ToggleFavoriteCubit>()),
        BlocProvider(create: (_) => sl<PropertyDetailsCubit>()),
      ],
      child: BlocListener<PropertyDetailsCubit, PropertyDetailsState>(
        listener: _handlePropertyDetailsState,
        child: asSliver ? _buildSliverList() : _buildBoxList(),
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList.separated(
      itemCount: properties.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _buildCard(properties[index], context),
    );
  }

  Widget _buildBoxList() {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: properties.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _buildCard(properties[index], context),
    );
  }

  Widget _buildCard(Property property, BuildContext context) {

    return RepaintBoundary(
    
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: PropertyCard(
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