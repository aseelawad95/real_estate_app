import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_dropdown_textdield.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/location/presentation/bloc/getlocation/getlocation_cubit.dart';

class LocationBlocBuilder extends StatelessWidget {
  final ValueChanged<Location> onSelected;

  const LocationBlocBuilder({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetlocationCubit, GetlocationState>(
      builder: (context, state) {
        if (state is GetlocationLoading) {
          return const Center(child: SizedBox());
        }

        if (state is GetlocationError) {
          debugPrint("Error: ${state.message}");
          return CustomText(text: state.message);
        }

        if (state is GetlocationLoaded) {
          final locations = state.locations;

          if (locations.isEmpty) {
            return const CustomText(text: "No locations available");
          }

          final items = locations
              .map((loc) => "${loc.city} - ${loc.street}")
              .toList();

          return CustomDropDownTextField(
            hintText: "Location",
            icon: CupertinoIcons.location_solid,
            items: items,
            onChanged: (String? selectedLabel) {
              if (selectedLabel == null) return;

              final selectedLocation = locations.firstWhere(
                (loc) => "${loc.city} - ${loc.street}" == selectedLabel,
              );

              onSelected(selectedLocation);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}