import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/core/constants/app_colors.dart';
import 'package:real_estate/features/propertyType/presentation/bloc/property_type_cubit.dart';

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({super.key,});
  

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyTypeCubit, PropertyTypeState>(
      builder: (context, state) {
        if (state is PropertyTypeLoading) {
          return const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is PropertyTypeError) {
          return SizedBox(
            height: 80,
            child: Center(
              child: CustomText(
                text: state.message,
                color: Colors.red,
              ),
            ),
          );
        }

        if (state is PropertyTypeLoaded) {
          final propertyType = state.propertyType;

          if (propertyType.isEmpty) {
            return const SizedBox(
              height: 80,
              child: Center(child: Text("No Property Type found")),
            );
          }

          return Align(
            alignment: AlignmentGeometry.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(propertyType.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: ContainerData(
                      color: selectedIndex == index
                          ? AppColors.secondaryColor
                          : Colors.white,
                      icon: propertyType[index].icon,
                      text: propertyType[index].name,
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
                margin: EdgeInsets.all(6),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grayColor,width: 2),
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