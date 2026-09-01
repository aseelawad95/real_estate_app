import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';

class PropertyType extends Equatable {
  final int id;
  final String name;
  final String icon;
  final String description;
  final List<Property>? properties;

  const PropertyType({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
     this.properties,
  });

  @override
  List<Object?> get props => [id, name, icon, description, properties];
}
