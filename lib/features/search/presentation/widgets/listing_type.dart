import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/property/presentation/bloc/getproperty/getproperty_cubit.dart';
import 'package:real_estate/features/property/presentation/widgets/property_list.dart'; 

class ListingType extends StatefulWidget {
  const ListingType({super.key});

  @override
  State<ListingType> createState() => _ListingTypeState();
}

class _ListingTypeState extends State<ListingType> {
  String? selectedType;

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
            final allProperties = state.property;

            if (allProperties.isEmpty) {
              return const Center(child: Text('No properties found'));
            }

            final filteredProperties = selectedType == null
                ? allProperties
                : allProperties
                    .where((p) => p.listingType == selectedType)
                    .toList();

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterButton("Rent"),
                    _buildFilterButton("Sale"),
                  ],
                ),
                const SizedBox(height: 15),

                if (selectedType == null)
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text('اختر نوع العقار'),
                  )
                else if (filteredProperties.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text('No properties match this filter'),
                  )
                else
                  PropertyListPage(
                    properties: filteredProperties, 
                  ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterButton(String type) {
    final bool isSelected = selectedType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = isSelected ? null : type;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: isSelected ? AppColors.primaryColor : AppColors.grayColor,
          ),
          child: Center(
            child: CustomText(
              text: type,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}