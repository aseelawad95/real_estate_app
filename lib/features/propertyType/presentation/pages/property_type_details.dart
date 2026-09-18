import 'package:flutter/material.dart';
import 'package:real_estate/common/widgets/custom_text.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';
import 'package:real_estate/features/property/presentation/widgets/property_list.dart';

class PropertyTypeDetailsPage extends StatelessWidget {
  const PropertyTypeDetailsPage({
    super.key,
    required this.typeName,
    required this.properties,
  });

  final String typeName;
  final List<Property> properties;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: typeName,
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        child: SingleChildScrollView(
          child: PropertyListPage(properties: properties),
        ),
      ),
    );
  }
}