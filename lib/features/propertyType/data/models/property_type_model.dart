
import 'package:real_estate/features/property/data/models/property_model.dart';
import 'package:real_estate/features/propertyType/domain/entities/property_type.dart';

class PropertyTypeModel {
  final int id;
  final String name;
  final String icon;
  final String description;
  final List<PropertyModel>? properties;

  PropertyTypeModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
     this.properties,
  });

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) {
    return PropertyTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map((e) => PropertyModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'description': description,
      'properties': properties?.map((e) => e.toJson()).toList(),
    };
  }

  PropertyType toEntity() {
    return PropertyType(
      id: id,
      name: name,
      icon: icon,
      description: description,
      properties: properties?.map((e) => e.toEntity()).toList(),
    );
  }
}