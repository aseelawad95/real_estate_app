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
  const PropertyListPage({super.key, this.properties});
  final List<Property>? properties;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetpropertyCubit, GetpropertyState>(
      listener: (context, state) {
        if (state is GetpropertyError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: BlocProvider(
        create: (_) => sl<ToggleFavoriteCubit>(),
        child: BlocBuilder<GetpropertyCubit, GetpropertyState>(
          builder: (context, state) {
            if (state is GetpropertyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetpropertyError) {
              debugPrint("err:${state.message}");
              return Center(child: Text(state.message));
            }

            if (state is GetpropertyLoaded) {
              final properties = state.property;

              if (properties.isEmpty) {
                return const Center(child: Text('No properties found'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final p = properties[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: BlocProvider(
                      create: (_) => sl<PropertyDetailsCubit>(),
                      child: Builder(
                        builder: (context) {
                          return BlocListener<PropertyDetailsCubit,
                              PropertyDetailsState>(
                            listener: (context, state) {
                              if (state is PropertyDetailsLoading) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (state is PropertyDetailsLoaded) {
                                Navigator.pop(context); // close loading dialog
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PropertyDetailsScreen(
                                      property: state.propertyDetails,
                                    ),
                                  ),
                                );
                              } else if (state is PropertyDetailsError) {
                                Navigator.pop(context); // close loading dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<PropertyDetailsCubit>()
                                    .propertyDetails(p.id);
                              },
                              child: PropertyCard(
                                initialIsFavorite: p.isFavourite,
                                id: p.id,
                                sqft: p.area,
                                baths: p.bathrooms,
                                beds: p.bedrooms,
                                imageUrl:
                                    p.images.isNotEmpty ? p.images[0] : '',
                                price: p.price,
                                title: p.title ?? "",
                                location: p.location?.city ?? p.typeName,
                                isVerified: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}