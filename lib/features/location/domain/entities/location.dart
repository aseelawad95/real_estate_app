import 'package:equatable/equatable.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';

class Location extends Equatable {
  final int id;
  final String country;
  final String city;
  final String street;
  final String buildingNo;
  final String zipCode;
  final double latitude;
  final double longitude;
  final List<Property>? properties;

  const Location({
    required this.id,
    required this.country,
    required this.city,
    required this.street,
    required this.buildingNo,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    this.properties,
  });

  @override
  List<Object?> get props => [
        id,
        country,
        city,
        street,
        buildingNo,
        zipCode,
        latitude,
        longitude,
        properties,
      ];
}