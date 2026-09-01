import 'package:equatable/equatable.dart';

class Property extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final double price;
  final int area;
  final int bedrooms;
  final int bathrooms;
  final String status;
  final String listingType;
  final int approvalStatus;
  final String typeName;
  final String typeIcon;
  final String ownerName;
  final List<String> images;
  final List<dynamic> reviews;

  const Property({
    required this.id,
    this.title,
    this.description,
    required this.price,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.status,
    required this.listingType,
    required this.approvalStatus,
    required this.typeName,
    required this.typeIcon,
    required this.ownerName,
    required this.images,
    this.reviews = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        area,
        bedrooms,
        bathrooms,
        status,
        listingType,
        approvalStatus,
        typeName,
        typeIcon,
        ownerName,
        images,
        reviews,
      ];
}