import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/propertyType/presentation/bloc/property_type_cubit.dart';
import 'package:real_estate/features/propertyType/presentation/pages/property_type_details.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyTypeCubit, PropertyTypeState>(
      builder: (context, state) {
        if (state is PropertyTypeLoading) {
          return const SizedBox(height: 80, child: Center(child: CircularProgressIndicator()));
        }
        if (state is PropertyTypeError) {
          return SizedBox(height: 80, child: Center(child: CustomText(text: state.message, color: Colors.red)));
        }
        if (state is PropertyTypeLoaded) {
          final propertyType = state.propertyType;
          if (propertyType.isEmpty) {
            return const SizedBox(height: 80, child: Center(child: Text("No Property Type found")));
          }
          return Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(propertyType.length, (index) {
                  final type = propertyType[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PropertyTypeDetailsPage(
                            typeName: type.name,
                            properties: type.properties!,
                          ),
                        ),
                      );
                    },
                    child: ContainerData(
                      color: Colors.white,
                      icon: type.icon,
                      text: type.name,
                    ),
                  );
                }),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ContainerData extends StatelessWidget {
  const ContainerData({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });

  final Color color;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(6),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grayColor, width: 2),
          ),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: icon,
              fit: BoxFit.cover,
              width: 22,
              height: 22,
              placeholder: (context, url) => const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image, size: 14),
            ),
          ),
        ),
        CustomText(
          text: text,
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}