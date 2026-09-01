import 'package:real_estate/features/favorite/domain/entities/favorite_entity.dart';

class FavoriteModel {
  final int id;
  final int propertyId;
  final String? propertyTitle;
  final String? propertyImageUrl;
  final double propertyPrice;
  final DateTime createdAt;

  FavoriteModel({
    required this.id,
    required this.propertyId,
    this.propertyTitle,
    this.propertyImageUrl,
    required this.propertyPrice,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] ?? 0,
      propertyId: json['propertyId'] ?? 0,
      propertyTitle: json['propertyTitle'],
      propertyImageUrl: json['propertyImageUrl'],
      propertyPrice: (json['propertyPrice'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'propertyImageUrl': propertyImageUrl,
      'propertyPrice': propertyPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  FavoriteEntity toEntity() {
    return FavoriteEntity(
      id: id,
      propertyId: propertyId,
      propertyTitle: propertyTitle,
      propertyImageUrl: propertyImageUrl,
      propertyPrice: propertyPrice,
      createdAt: createdAt,
    );
  }
}