import 'package:real_estate/features/location/domain/entities/location.dart';
import 'package:real_estate/features/property/data/models/property_model.dart';

class LocationModel {
  final int id;
  final String country;
  final String city;
  final String street;
  final String buildingNo;
  final String zipCode;
  final double latitude;
  final double longitude;
  final List<PropertyModel>? properties;

  LocationModel({
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

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0,
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      buildingNo: json['buildingNo'] ?? '',
      zipCode: json['zipCode'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map((e) => PropertyModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'street': street,
      'buildingNo': buildingNo,
      'zipCode': zipCode,
      'latitude': latitude,
      'longitude': longitude,
      'properties': properties?.map((e) => e.toJson()).toList(),
    };
  }

  Location toEntity() {
    return Location(
      id: id,
      country: country,
      city: city,
      street: street,
      buildingNo: buildingNo,
      zipCode: zipCode,
      latitude: latitude,
      longitude: longitude,
      properties: properties?.map((e) => e.toEntity()).toList(),
    );
  }
}