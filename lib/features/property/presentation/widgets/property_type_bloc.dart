import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_dropdown_textdield.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';
import 'package:real_estate/features/propertyType/presentation/bloc/property_type_cubit.dart';

class ProperyTypeBlocListener extends StatelessWidget {
  final ValueChanged<PropertyType> onSelected;

  const ProperyTypeBlocListener({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyTypeCubit, PropertyTypeState>(
      builder: (context, state) {
        if (state is PropertyTypeLoading) {
          return const Center(child: SizedBox());
        }

        if (state is PropertyTypeError) {
          return Text(state.message, style: const TextStyle(color: Colors.red));
        }

        if (state is PropertyTypeLoaded) {
          final types = state.propertyType; 

          return CustomDropDownTextField(
            icon: Icons.holiday_village_sharp,
            hintText: "Property Type",
            items: types.map((type) => type.name).toList(),
            onChanged: (String? selectedName) {
              if (selectedName == null) return;

              final selectedType = types.firstWhere(
                (type) => type.name == selectedName,
              );

              onSelected(selectedType);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}