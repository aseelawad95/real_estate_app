import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/widgets/property_card.dart';

class PropertyListPage extends StatelessWidget {
  const PropertyListPage({super.key, this.properties});
  final List<Property>? properties;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetpropertyCubit, GetpropertyState>(
      listener: (context, state) {
        if (state is GetpropertyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        
      },
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
                  child: PropertyCard(
                    sqft: p.area,
                    baths: p.bathrooms,
                    beds: p.bathrooms,
                    imageUrl: p.images.isNotEmpty ? p.images[0] : '',
                    price: p.price,
                    title: p.title ?? "",
                    location: p.status,
                   isVerified: true,
                    // area: p.area,
                    // approvalStatus: p.approvalStatus,
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}