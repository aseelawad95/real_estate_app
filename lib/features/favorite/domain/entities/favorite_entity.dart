import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final int id;
  final int propertyId;
  final String? propertyTitle;
  final String? propertyImageUrl;
  final double propertyPrice;
  final DateTime createdAt;

  const FavoriteEntity({
    required this.id,
    required this.propertyId,
    this.propertyTitle,
    this.propertyImageUrl,
    required this.propertyPrice,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        propertyId,
        propertyTitle,
        propertyImageUrl,
        propertyPrice,
        createdAt,
      ];
}